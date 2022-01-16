//
//  AppManager.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation

class AppManager: ObservableObject {
    
    @Published var student: Student?
    @Published var error = ""
    
    func loadData(username: String, password: String) async throws {
        let gradeService = GradeService(username, password)
        let loadedResult: Result = try await gradeService.fetchData()
        student = loadedResult.studentData
    }

}
