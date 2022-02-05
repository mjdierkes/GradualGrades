//
//  ContentView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/15/22.
//

import SwiftUI

/// Loads into the SplashScreen then moves into Login or Homepage.
struct ContentView: View {
    
    @StateObject var manager = AppManager()
    @StateObject var preferences = PreferencesManager()
    
    @State var presentingUUID = UUID()
    
    var body: some View {
        SplashScreen()
            .environmentObject(manager)
            .environmentObject(preferences)
            .preferredColorScheme(preferences.appearance)
//            .popover(
//                present: $manager.networkOffline,
//                attributes: {
//                    $0.sourceFrameInset = UIEdgeInsets(16)
//                    $0.position = .relative(
//                        popoverAnchors: [
//                            .bottom,
//                        ]
//                    )
//                    $0.presentation.transition = .move(edge: .bottom)
//                    $0.dismissal.transition = .move(edge: .bottom)
//                    $0.dismissal.mode = [.dragDown]
//                    $0.dismissal.dragDismissalProximity = 0.1
//                }
//            ) {
//                NotificationViewPopover()
//            }
        }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
