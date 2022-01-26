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
    @KeychainStorage("username") var savedUsername = ""
    @KeychainStorage("password") var savedPassword = ""
    
    var body: some View {
        LoginPage()
            .environmentObject(manager)
            .environmentObject(preferences)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
