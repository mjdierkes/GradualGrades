//
//  GreetingView.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/1/22.
//

import SwiftUI

struct GreetingView: View {
    
    @EnvironmentObject var manager: AppManager
    @AppStorage("ShowGPA") var showGPA = true
    @State private var showingSetup = false
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading){
                Text("Good \(dayTime()) \(manager.firstName)")
                    .padding(.horizontal)
                    .padding(.top)
                    .font(.title2)
                    .font(.system(.body, design: .rounded))
                    .onTapGesture(count: 2) {
                        withAnimation {
                            showGPA.toggle()
                        }
                    }
                
                
                if let gpa = manager.gpa?.roundedWeightedGPA {
                    if showGPA {
                        VStack(alignment: .leading) {
                            Text(gpa)
                                .font(.largeTitle)
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.medium)
                                .padding(.horizontal)
                            
                            
                            Text("Live GPA")
                                .bold()
                                .foregroundColor(Color("GradGreen"))
                                .padding(.horizontal)
                        }

                    }
                    else {
                        Text("GPA Hidden")
                            .bold()
                            .foregroundColor(Color("BorderGray"))
                            .padding(.horizontal)
                            .padding(.vertical, 2)
                    }
                }
            }
            
            Spacer()
        }
        .sheet(isPresented: $showingSetup) {
            GPASetupPage()
        }
        .background(Color("Background"))
        .onTapGesture(count: 2) {
            withAnimation {
                showGPA.toggle()
            }
        }
//        .onTapGesture {
//            showingSetup = true
//        }
        
    }
    
    func dayTime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12 :
            return "Morning"
        case 12..<24 :
            return "Afternoon"
        default:
            return "Day"
        }
    }
    
}



struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView()
    }
}
