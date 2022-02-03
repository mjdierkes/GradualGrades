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
    
    var body: some View {
        
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
                            .padding(.top, 1)
                        
                        
                        Text("Live GPA")
                            .bold()
                            .foregroundColor(Color("GradGreen"))
                            .padding(.horizontal)
                            .padding(.bottom, 1)
                    }
                    .onTapGesture(count: 2) {
                        withAnimation {
                            showGPA.toggle()
                        }
                    }
                }
            }
            
            
            
            
        }
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
