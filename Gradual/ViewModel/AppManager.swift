//
//  AppManager.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation

class AppManager: ObservableObject {
    
    @Published var student: Student?
    @Published var classes = [Class]()
    @Published var classAssignments = [Assignment]()
    @Published var error = ""
    
    var firstName: String {
        return student?.studentName.components(separatedBy: " ")[0] ?? "Student"
    }
    
    func loadData(username: String, password: String) async throws {
        let gradeService = GradeService(username, password)
        
        let loadedResult: Result = try await gradeService.fetchData()
        let loadedClasses: Classes = try await gradeService.fetchData()
//        let loadedAssignments: [ClassDetails] = try await gradeService.fetchData()
        
        
        student = loadedResult.studentData
        classes = loadedClasses.currentClasses
        
        //TODO: Add preventative measures for crashing
        for i in 0..<classes.count {
            classes[i].name = classes[i].name.components(separatedBy: "  ")[2]
        }
        
        for i in 0..<classes.count {
            classes[i].name = classes[i].name.components(separatedBy: " S2")[0]
        }
        
        
//        classAssignments = loadedAssignments.
    }
    
    
    

}
