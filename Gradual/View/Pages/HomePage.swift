//
//  HomePage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct HomePage: View {
    
    @EnvironmentObject var manager: AppManager
    @State private var liveGPA = ""
    
    var body: some View {
        
        VStack {
            Header()
            ScrollView(.vertical, showsIndicators: false) {
                NavigationLink(destination: LoginPage(), isActive: .constant(manager.student == nil)) {}
                
                VStack(alignment: .leading){
                    Text("Good \(dayTime()) \(manager.firstName)")
                        .padding(.top, 10)
                        .padding(.horizontal)
                        .font(.title2)
                        .font(.system(.body, design: .rounded))
                    
                    Text(manager.gpa?.roundedWeightedGPA ?? "ERROR")
                        .font(.largeTitle)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                        .padding(.horizontal)
                        .padding(.vertical, 1)
                    
                    CardView()
                    
                    Text("Grades")
                        .padding()
                        .font(.title2)
                        .font(.system(.body, design: .rounded))
                    
                    ForEach($manager.classes) { details in
                        NavigationLink(destination: AssignmentPage(classDetails: details)) {
                            SimpleClassView(classData: details)
                        }
                        .tint(.black)
                    }
                    
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
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

struct HomePage_Previews: PreviewProvider {
    @StateObject static var manager = AppManager()
    static var previews: some View {
        HomePage()
            .environmentObject(manager)
    }
}
