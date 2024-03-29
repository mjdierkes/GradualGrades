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

    var body: some View {
        Group {
            VStack {
                ScrollView(showsIndicators: false) {
                    GreetingView()
                    CardStackView()
                    ClassGradesView()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                AccountToolButton()
            }
            ToolbarItem(placement: .navigationBarLeading) {
                RefreshToolButton()
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color("Background"))
        .navigationBarTitleDisplayMode(.inline)
        .overlay(
            DetailPage()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

        )
    }
    
}

struct HomePage_Previews: PreviewProvider {
    @StateObject static var manager = AppManager()
    static var previews: some View {
        HomePage()
            .environmentObject(manager)
    }
}
