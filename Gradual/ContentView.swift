//
//  ContentView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/15/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = AppManager()
    @StateObject var preferences = PreferencesManager()
    
    @State private var dataLoaded = false
    
    var body: some View {
        LoginPage()
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
