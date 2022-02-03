//
//  ContentView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/15/22.
//

import SwiftUI
import Network

/// Loads into the SplashScreen then moves into Login or Homepage.
struct ContentView: View {
    
    @StateObject var manager = AppManager()
    @StateObject var preferences = PreferencesManager()
    
    @State private var networkOffline = false
    @State var presentingUUID = UUID()
    
    var body: some View {
        SplashScreen()
            .environmentObject(manager)
            .environmentObject(preferences)
            .preferredColorScheme(preferences.appearance)
            .popover(
                present: $networkOffline,
                attributes: {
                    $0.sourceFrameInset = UIEdgeInsets(16)
                    $0.position = .relative(
                        popoverAnchors: [
                            .bottom,
                        ]
                    )
                    $0.presentation.transition = .move(edge: .bottom)
                    $0.dismissal.transition = .move(edge: .bottom)
                    $0.dismissal.mode = [.dragDown]
                    $0.dismissal.dragDismissalProximity = 0.1
                }
            ) {
                NotificationViewPopover()
            }
            .onAppear {
                getNetworkStatus()
            }
    }
    
    func getNetworkStatus() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                self.networkOffline = false
            } else {
                self.networkOffline = true
                print("NETWORK OFFLINE")
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
