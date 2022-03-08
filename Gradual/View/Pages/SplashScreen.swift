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
    
    @AppStorage("isNewUser") var isNewUser = true
    @State private var presentingView = true
    var body: some View {
        GeometryReader{ proxy in
            
            ZStack {
                NavigationView {
                    ZStack {
                        NavigationLink(destination: HomePage(), isActive: .constant(manager.student != nil)) {
                            EmptyView()
                        }
//                        .isDetailLink(false)
//                        if dataLoading {
//                            ZStack {
//                                Color("Background")
//                                    .ignoresSafeArea()
//                            }
//                        }
//                        else {
//                            LoginPage(dataLoading: $dataLoading)
//                        }
                        
                    }
                }
                .navigationViewStyle(.stack)
                if isNewUser && presentingView{
                    let size = proxy.size
                    OnboardingPage(screenSize: size, presentingView: $presentingView)
                }
            }
            .accentColor(Color("GradGreen"))
            .onAppear(perform: {
                /// Attempt to load the data from keychain.
                /// This screen will disappear if logged in.
                Task {
                    do {
                        manager.dataLoading = true
                        try await manager.reload()
                        manager.error = ""
                        withAnimation {
                            dataLoading = false
                        }
                        manager.dataLoading = false
                    } catch {
                        print("Unable to load data from Keynanchain")
                        withAnimation {
                            dataLoading = false
                        }
                        manager.dataLoading = false
                    }
                }
            })
        }
    }
    
}




struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
