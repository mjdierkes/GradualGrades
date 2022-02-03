//
//  NotificationService.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/3/22.
//

import Foundation
import UserNotifications

class NotificationService {
    
    
    
    
    
    func requestAccess() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notifications setup!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    
}
