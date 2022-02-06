//
//  NotificationService.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/3/22.
//

import Foundation
import UserNotifications
import KeychainAccess
import UIKit

class NotificationService {
    
    let cache = CacheService()
    let keychain = Keychain(service: "life.gradual.api")
    
    var previousClasses: [Class]?
    var classes: [Class]?
    
    var updateTimer: Timer?
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        update()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func reinstateBackgroundTask() {
        if updateTimer != nil && backgroundTask == .invalid {
            registerBackgroundTask()
        }
    }
    
    func registerBackgroundTask() {
        print("Registering Background Task")
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != .invalid)
        updateTimer = Timer.scheduledTimer(timeInterval: 5.5, target: self,
               selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    
    func endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
    
    
    func requestAccess() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notifications setup!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    @objc func update() {
        Task {
            do {
                try await loadData()
                getNewAssignments()
                cache.save(data: classes, forKey: "Classes")
            } catch {
                print(error)
            }
        }
    }
    
    func getNewAssignments() {
        
        guard let classes = classes else {
            print("Classes are nil")
            return
        }
        
        guard let previousClasses = previousClasses else {
            print("Previous classes are nil")
            return
        }
        
        for (classDetails, previousDetails) in zip(classes, previousClasses) {
            let difference = classDetails.assignments.gradeDifference(from: previousDetails.assignments)
            print(difference)
            for difference in difference {
                if difference.score != "" {
                    sendNotification(title: difference.assignment, subtitle: "Grade changed to " + difference.score)
                }
            }
        }
        
                
    }
    
    
    func loadData() async throws {
        guard let username = try self.keychain.get("username") else {
            print("Can't get username")
            return
        }
        guard let password = try self.keychain.get("password") else {
            print("Can't get password")
            return
        }
        
        if let cachedData: [Class] = cache.load(forKey: "Classes"){
            previousClasses = cachedData
        }
        
        let gradeService = GradeService(username, password)
        let loadedClasses: Classes = try await gradeService.fetchData(from: .currentClasses)
        classes = loadedClasses.currentClasses
    }
    
    func sendNotification(title: String, subtitle: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    

    
}

extension Array where Element: Hashable {
    func gradeDifference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

