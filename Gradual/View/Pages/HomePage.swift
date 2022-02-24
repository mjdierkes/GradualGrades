//
//  HomePage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

/// This is the main page of the app.
/// Users can check Upcoming Assignments, Grades, and GPA.
struct HomePage: View {
    @EnvironmentObject var manager: AppManager
    @State private var showingGiftPage = false
    @AppStorage("offerAvailable") var offerAvailable = true

    var body: some View {
        Group {
            VStack {
                ScrollRefreshable(content: {
                        GreetingView()
                        RecentAssignmentStack()
                        CardStackView()
                        ClassGradesView()
                }){
                    do {
                        try await manager.reload()
                    } catch {
                        print("Unable to reload")
                    }
                }
            }
        }
        .sheet(isPresented: $showingGiftPage){
            WelcomeGiftPage()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                AccountToolButton()
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color("Background"))
        .navigationBarTitleDisplayMode(.inline)
        .overlay(
            DetailPage()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

        )
        .onAppear {
            if offerAvailable {
                showingGiftPage = true
            }
            offerAvailable = false
        }
    }
    
}

struct HomePage_Previews: PreviewProvider {
    @StateObject static var manager = AppManager()
    static var previews: some View {
        HomePage()
            .environmentObject(manager)
    }
}
