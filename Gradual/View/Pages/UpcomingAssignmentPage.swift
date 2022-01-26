//
//  UpcomingAssignmentPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/23/22.
//

import SwiftUI

struct UpcomingAssignmentPage: View {
    
    @State private var showSafari: Bool = false

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
                
                HStack {
                    ZStack{
                        Button {
                            
                        } label: {
                            Text("Goal 1600")
                                .font(.system(size: 14))
                                .foregroundColor(Color("GradGreen"))
                        }
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 25)
                    .background(Color("LowGreen"))
                    .cornerRadius(50)
                    
                    Text("Current 1290")
                    
                }
                
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
        })

    }
}

struct UpcomingAssignmentPage_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingAssignmentPage()
    }
}
