//
//  AppManager.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation
import Network
import KeychainAccess

@MainActor class AppManager: ObservableObject {
    
    @Published var student: Student?
    @Published var classes = [Class]()
    @Published var gpa: GPA?
    
    @Published var nextSAT = ""
    @Published var error = ""
    @Published var showingAccountPage = false
    
    @Published var cards = [Card]()
    @Published var networkOffline = false

    @Published var recentAssignments = [Assignment]()
    
    let keychain = Keychain(service: "life.gradual.api")
    var schedule: [ClassMeta]?
    
    let defaults = UserDefaults.standard
    let cache = CacheService()
    let notificationService = NotificationService()
    
    var firstName: String {
        return student?.name.components(separatedBy: " ")[1] ?? "Student"
    }
    
    public init() {
        getNetworkStatus()
    }
    
    
    /// Attempt to fetch username and password, then load data from server.
    /// Call this function user login and reload button.
    func reload() async throws{
        
        if let cachedData: [Class] = cache.load(forKey: "Classes"){
            classes = cachedData
        }
        
        if let cachedStudent: Student = cache.load(forKey: "Student"){
            student = cachedStudent
        }
        if let cachedSAT: String = cache.load(forKey: "NextSAT"){
            nextSAT = cachedSAT
        }
        if let cachedGPA: GPA = cache.load(forKey: "GPA"){
            gpa = cachedGPA
        }
        if let cachedCards: [Card] = cache.load(forKey: "Cards"){
            cards = cachedCards
        }
        print("RELOAD")
        guard let username = try self.keychain.get("username") else {
            print("Can't get username")
            return
        }
        guard let password = try self.keychain.get("password") else {
            print("Can't get password")
            return }
    
        try await loadData(username: username, password: password)
        notificationService.update()
        recentAssignments = notificationService.recentAssignments
    }
    
    /// Attempts to access the API and initialize stored properties.
    func loadData(username: String, password: String, newSignIn: Bool = false) async throws {
        print("LOADING")
        let gradeService = GradeService(username, password)
        let loadedClasses: Classes = try await gradeService.fetchData(from: .currentClasses)
        let schedule: Schedule = try await gradeService.fetchData(from: .schedule)
        
        self.schedule = schedule.schedule
//        if(newSignIn){
            saveCredentials(username: username, password: password)
//        }
        
        classes = loadedClasses.currentClasses
        populateClassInfo()
        filterClassnames()
        
        do {
            gpa = try await gradeService.fetchData(from: .GPA)
        } catch {
            print("Unable to load GPA")
        }

        let loadedSATs: UpcomingSATs = try await gradeService.fetchData(from: .satDates)
        if !loadedSATs.liveDates.isEmpty {
            nextSAT = loadedSATs.liveDates[0]
            defaults.set(loadedSATs.liveDates[0], forKey: "SAT-Date")
        } else {
            nextSAT = defaults.object(forKey: "SAT-Date") as! String
        }

        if let student: Student = try await gradeService.fetchData(from: .studentInfo) {
            cache.save(data: student, forKey: "Student")
            self.student = student
        }
        cache.save(data: classes, forKey: "Classes")
        cache.save(data: nextSAT, forKey: "NextSAT")
        cache.save(data: gpa, forKey: "GPA")
        
        cards = [Card]()
        getUpcomingAssignments()

        cache.save(data: cards, forKey: "Cards")

    }
    
    /// Invalidates the users credentials and removes all stored data.
    func signOut() {
        let keychain = Keychain(service: "life.gradual.api")
        do {
            try keychain.remove("username")
            try keychain.remove("password")
            try cache.storage?.removeAll()
        } catch {
            print(error)
        }
        student = nil
        gpa = nil
        cards = [Card]()
        classes = [Class]()
        showingAccountPage = false
    }
    
    func saveCredentials(username: String, password: String){
        print("SIGN IN")

        DispatchQueue.global().async {
            do {
                try self.keychain
                    .set(username, key: "username")
                
//                guard let requireFaceID = self.defaults.object(forKey: "FaceID") else { return }
//                print(requireFaceID)
//                if requireFaceID as? Bool ?? false {
//                    print("FaceID", requireFaceID)
//                    try self.keychain
//                        .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: [.biometryAny])
//                        .set(password, key: "password")
//                    print("Password", password)
//                }
//                else {
                    try self.keychain
                        .set(password, key: "password")
                    print("Password", password)
//                }
                
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
    
    
    func getNetworkStatus() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")

        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.networkOffline = path.status != .satisfied
                print(path.status)
            }
        }
        monitor.start(queue: queue)
    }
    
    
    func getUpcomingAssignments() {
        
        print("Upcoming Assignments Loading")
        print("Cards", cards)
        var output = [Assignment]()
        let dateFormatter = DateFormatter()
        let stringFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        stringFormatter.dateStyle = .full
        
        let today = Date()
        
        var assessments = [Assignment]()
        
        for classDetails in classes {
            for var assessment in classDetails.assignments {
                assessment.percentChange = classDetails.getPercentChange()
                assessment.className = classDetails.name
                assessments.append(assessment)
            }
        }
        
        var index = 0
        for assessment in assessments {
            if let date = dateFormatter.date(from: assessment.dateDue) {
                if date > today {
                    output.append(assessment)
                    cards.append(Card(id: index, name: assessment.assignment, className: assessment.className, dueDate: stringFormatter.string(from: date), assignment: assessment))
                    index += 1
                }
            } else {
                print("Unable to convert date")
            }
        }
                
                    
    }
    
    
    func populateClassInfo() {
        if let schedule = schedule {
            for meta in schedule {
                if let i = classes.firstIndex(where: { $0.name.contains(meta.courseCode) }) {
                    classes[i].meta = meta
                }
            }
        }
    }

    
}
