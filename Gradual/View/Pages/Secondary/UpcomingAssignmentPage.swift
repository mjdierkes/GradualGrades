//
//  UpcomingAssignmentPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/23/22.
//

import SwiftUI

struct UpcomingAssignmentPage: View {
    
    @State private var showSafari: Bool = false
    @State private var showingGoalPage = false
    @EnvironmentObject var preferences: PreferencesManager

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Image("CollegeBoard-Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 25)
                Text("Upcoming SAT March 14th at Frisco High School")
                    .font(.title)
                    .font(.system(.body, design: .rounded))
                    .padding(.vertical, 1)
                
                Text("The SAT is an entrance exam used by most colleges and universities to make admissions decisions. ")
                
                Spacer()
            }
            
            HStack {
                Spacer()
                Button {
                    showSafari.toggle()
                } label: {
                    Text("Register")
                        .font(.headline)
                        .frame(maxWidth: 175)
                        .padding(.vertical, 5)
                }
                .tint(Color("GradGreen"))
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            }
            
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showSafari, content: {
                SFSafariViewWrapper(url: URL(string: "https://satsuite.collegeboard.org/sat/registration")!)
                .ignoresSafeArea()
        })
        .sheet(isPresented: $showingGoalPage){
            GoalSetPage()
        }

    }
}

struct UpcomingAssignmentPage_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingAssignmentPage()
    }
}
