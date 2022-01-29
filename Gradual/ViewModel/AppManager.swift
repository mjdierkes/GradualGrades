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

    @Published var cards = [String](repeating: "Testing", count: 1)


    let keychain = Keychain(service: "life.gradual.api")

    
    let defaults = UserDefaults.standard
    
    var firstName: String {
        return student?.name.components(separatedBy: " ")[1] ?? "Student"
    }
    
    /// Attempt to fetch username and password, then load data from server.
    /// Call this function user login and reload button.
    func reload() async throws{
        print("RELOAD")
        guard let username = try self.keychain.get("username") else { return }
        guard let password = try self.keychain.get("password") else { return }
    
        try await loadData(username: username, password: password)
    }
    
    /// Attempts to access the API and initialize stored properties.
    func loadData(username: String, password: String, newSignIn: Bool = false) async throws {
        let gradeService = GradeService(username, password)
        let loadedClasses: Classes = try await gradeService.fetchData(from: .currentClasses)
        
        if(newSignIn){
            saveCredentials(username: username, password: password)
        }
        
        classes = loadedClasses.currentClasses
        filterClassnames()
        
        do {
            gpa = try await gradeService.fetchData(from: .GPA)
        } catch {
            print("Unable to load GPA")
        }
//
        let loadedSATs: UpcomingSATs = try await gradeService.fetchData(from: .satDates)
        if !loadedSATs.liveDates.isEmpty {
            nextSAT = loadedSATs.liveDates[0]
            defaults.set(loadedSATs.liveDates[0], forKey: "SAT-Date")
        } else {
            nextSAT = defaults.object(forKey: "SAT-Date") as! String
            print("SAT Loaded from defaults")
        }
//
        student = try await gradeService.fetchData(from: .studentInfo)
    }
    
    /// Invalidates the users credentials and removes all stored data.
    func signOut() {
        let keychain = Keychain(service: "life.gradual.api")
        do {
            try keychain.remove("username")
            try keychain.remove("password")
        } catch {
            print("error: \(error)")
        }
        student = nil
    }
    
    func saveCredentials(username: String, password: String){
        print("SIGN IN")

        DispatchQueue.global().async {
            do {
                try self.keychain
                    .set(username, key: "username")
                
                guard let requireFaceID = self.defaults.object(forKey: "FaceID") else { return }
                print(requireFaceID)
                if requireFaceID as? Bool ?? false {
                    print("FaceID", requireFaceID)
                    try self.keychain
                        .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: [.biometryAny])
                        .set(password, key: "password")
                }
                else {
                    try self.keychain
                        .set(password, key: "password")
                }
                
            } catch {
                print(error)
            }
        }
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
    
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
    
}
