//
//  GradualApp.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/15/22.
//

import SwiftUI

@main
struct GradualApp: App {
    let notificationService = NotificationService()
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .background {
                        print("Background")
                        notificationService.registerBackgroundTask()
                    }
                }
        }
    }
}
