//
//  LoginPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

/// This is the first page that is loaded when the app is launched.
/// It attempts to call the api with stored credentials.
/// If not, the user will be presented with a login screen.
struct SplashScreen: View {
    
    @EnvironmentObject var manager: AppManager
    @State private var dataLoading = true
    
    var body: some View {
        NavigationView {
            ZStack {
                if manager.student != nil {
                    HomePage()
                }
                else if dataLoading {
                    ZStack {
                        Color("Background")
//                        Image("GradHat")
                    }
                    .ignoresSafeArea()
                }
                else {
                   LoginPage(dataLoading: $dataLoading)
                }
            }
        }
        .navigationBarHidden(true)
        /// Attempt to load the data from keychain.
        /// This screen will disappear if logged in.
        .onAppear(perform: {
            Task {
                do {
                    try await manager.reload()
//                    username = ""
//                    password = ""
                    manager.error = ""
                    withAnimation {
                        dataLoading = false
                    }
                } catch {
                    print("Unable to load data from Keynanchain")
                    withAnimation {
                        dataLoading = false
                    }
                }
            }
        })
    }

}




struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
