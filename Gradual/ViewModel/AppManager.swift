//
//  AppManager.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation
import KeychainAccess

@MainActor class AppManager: ObservableObject {
    
    @Published var student: Student?
    @Published var classes = [Class]()
    @Published var gpa: GPA?
    
    @Published var nextSAT = ""
    @Published var error = ""

    
    let defaults = UserDefaults.standard
    
    var firstName: String {
        return student?.name.components(separatedBy: " ")[1] ?? "Student"
    }
    
    /// Attempts to access the API and initialize stored properties.
    func loadData(username: String, password: String) async throws {
        let gradeService = GradeService(username, password)
        
        let loadedClasses: Classes = try await gradeService.fetchData(from: .currentClasses)
        classes = loadedClasses.currentClasses

        gpa = try await gradeService.fetchData(from: .GPA)
        
        let loadedSATs: UpcomingSATs = try await gradeService.fetchData(from: .satDates)
        if !loadedSATs.liveDates.isEmpty {
            nextSAT = loadedSATs.liveDates[0]
            defaults.set(loadedSATs.liveDates[0], forKey: "SAT-Date")
        } else {
            nextSAT = defaults.object(forKey: "SAT-Date") as! String
            print("SAT Loaded from defaults")
        }
        
        filterClassnames()
        student = try await gradeService.fetchData(from: .studentInfo)
    }
    
    /// Invalidates the users credentials and removes all stored data.
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

    
    /// Calculates the new average score for assignments.
    /// This is used for the Doomsday calculator.
    ///
    /// Make sure to pass in Minor and Major grades separately.
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
    
    /// Cleans up the class names by removing unnecessary info.
    private func filterClassnames() {
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
            
            classes[i].name = name
        }
    }
    
    
}
