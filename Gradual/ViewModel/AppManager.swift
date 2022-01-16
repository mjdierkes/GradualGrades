//
//  AppManager.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation

class AppManager: ObservableObject {
    
    @Published var student: Student?

    func loadData(username: String, password: String) async {
        let gradeService = GradeService(username, password)
        
        do {
            let loadedResult: Result = try await gradeService.fetchData()
            student = loadedResult.studentData
        } catch {
            print(error)
        }
    }

}
