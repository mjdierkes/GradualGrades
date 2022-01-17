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

        
//        //TODO: Add preventative measures for crashing
        
//        print(classes.details[0].className.components(separatedBy: "  "))
        
//        for i in 0..<classes.details.count {
//            classes.details[i].className = classes.details[i].className.components(separatedBy: "  ")[1]
//        }
//
//        for i in 0..<classes.all.count {
//            classes.details[i].className = classes.details[i].className.components(separatedBy: " S2")[0]
//        }
        
        
    }
    
    func signOut() {
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "password")
        student = nil
    }
    
    
    
    

}
