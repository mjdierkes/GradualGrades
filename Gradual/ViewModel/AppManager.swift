//
//  AppManager.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation

class AppManager: ObservableObject {
    
    @Published var student: Student?
    @Published var classes = (all: [Class](), details: [ClassDetails]())
    @Published var error = ""
    
    let defaults = UserDefaults.standard

    var firstName: String {
        return student?.studentName.components(separatedBy: " ")[0] ?? "Student"
    }
    
    func loadData() async throws {
        if let username = defaults.object(forKey: "username") as? String {
            if let password = defaults.object(forKey: "password") as? String {
                try await loadData(username: username, password: password)
            }
        }
    
    }
    
    func loadData(username: String, password: String) async throws {
        let gradeService = GradeService(username, password)
        
        let loadedResult: Result = try await gradeService.fetchData()
        let loadedClasses: Classes = try await gradeService.fetchData()
        let loadedAssignments: AllGrades = try await gradeService.fetchData()
        
        
        student = loadedResult.studentData
        classes.all = loadedClasses.currentClasses
        classes.details = loadedAssignments.currentClassDetails
        
        defaults.set(username, forKey: "username")
        defaults.set(password, forKey: "password")
        
        print(classes.details[0].className.components(separatedBy: "  "))
        
        for i in 0..<classes.details.count {
            
            var name = classes.details[i].className
            var size = name.count

            name = String(name.components(separatedBy: "-")[1])
            size = name.count
            
            name = String(name.suffix(size - 2))
            size = name.count
            
            if name.contains("S2") || name.contains("S1"){
                name = String(name.prefix(size - 2))
            }
                
            classes.details[i].className = name
        }
    }
    
    func signOut() {
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "password")
        student = nil
    }
    
    func calculatedPercentChange(for newAssignment: Assignment, oldAssignments: [Assignment]) -> Double{
        var inclusiveAverage = oldAssignments
        inclusiveAverage.append(newAssignment)
        
        return getAverage(for: inclusiveAverage) - getAverage(for: oldAssignments)
    }
    
    
    func getAverage(for assignments: [Assignment]) -> Double{
        var average: Double = 0
        for assessment in assignments {
            if let score = Double(assessment.score){
                average += score
            }
        }
        average /= Double(assignments.count)
        
        return average
    }
    

}
