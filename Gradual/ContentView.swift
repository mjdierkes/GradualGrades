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
        
    var body: some View {
        SplashScreen()
            .environmentObject(manager)
            .environmentObject(preferences)
            .preferredColorScheme(preferences.appearance)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
