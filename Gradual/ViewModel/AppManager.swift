//
//  AppManager.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation
import KeychainAccess

class AppManager: ObservableObject {
    
    @Published var student: Student?
    @Published var classes = [Class]()
    @Published var gpa: GPA?

    @Published var error = ""
    
    let defaults = UserDefaults.standard

    var firstName: String {
        print(student?.name)
        return student?.name.components(separatedBy: " ")[1] ?? "Student"
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
        
        let loadedClasses: Classes = try await gradeService.fetchData()
        let loadedStudent: Student = try await gradeService.fetchStudent()
        let loadedGPA: GPA = try await gradeService.fetchGPA()
        
        classes = loadedClasses.currentClasses
        student = loadedStudent
        gpa = loadedGPA
        
        for i in 0..<classes.count {
            
            var name = classes[i].name
            var size = name.count

            name = String(name.components(separatedBy: "-")[1])
            size = name.count
            
            name = String(name.suffix(size - 6))
            size = name.count
            
            if name.contains("@CTE") {
                name = String(name.prefix(size - 7))
            }
            
            else if name.contains("S2") || name.contains("S1"){
                name = String(name.prefix(size - 2))
            }
            
            print(name)
            
                
            classes[i].name = name
        }
        
    }
    
    func signOut() {
        let keychain = Keychain(service: "credentials")
        do {
            try keychain.remove("username")
            try keychain.remove("password")
        } catch let error {
            print("error: \(error)")
        }
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
//    
//    func getNewAssignments(from assignments: [Assignment]) -> [Assignment] {
//        
//        
//        let oldClasses: Classes = defaults.object(forKey: "classes") as! Classes
//        
//        if oldClasses.hashValue != assignments.hashValue {
//            print("Assignments have been updated")
//            
//            for assessment in assignments {
//                let hashed = assessment.hashValue
//                
//            }
//        }
//
//    }
//    
    

}
