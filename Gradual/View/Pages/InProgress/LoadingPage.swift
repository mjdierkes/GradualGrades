//
//  LoadingPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/24/22.
//

import SwiftUI

struct LoadingPage: View {
    
    @EnvironmentObject var manager: AppManager
    @State private var finishedLoading = false
    var body: some View {
        VStack {
            if manager.student != nil {
                NavigationView{
                    HomePage()
                }
            }
            
            else {
                ZStack {
                    Color("GradGreen")
                        .ignoresSafeArea()
                    Image("GradHat")
                }
            }
        }
        .onAppear(perform: {
            Task {
                do {
                    try await manager.reload()
                    withAnimation {
                        finishedLoading = true
                    }
                    print(finishedLoading)
                } catch {
                    print("Unable to load data from Keynanchain")
                }
            }
        })
 
    }
}

struct LoadingPage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPage()
    }
}
