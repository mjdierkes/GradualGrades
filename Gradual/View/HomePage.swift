//
//  HomePage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct HomePage: View {
    
    @EnvironmentObject var manager: AppManager
    
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
//                    Text("3.98")
//                        .font(.largeTitle)
//                        .padding(.horizontal)
                    
//                    
//                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack {
//                            RecentAssignmentView()
//                                .padding(2)
//                            RecentAssignmentView()
//                                .padding(2)
//                            RecentAssignmentView()
//                                .padding(2)
//
//                        }
//                        .padding(.horizontal)
//                    }
//                    
//                    CardView()
                            
                    Text("Grades")
                        .padding()
                        .font(.title2)
                    
                    let _ = print(manager.classes)
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
        case 1..<12 :
            return "Morning"
        case 12..<22 :
            return "Afternoon"
        default:
            return ""
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    @StateObject static var manager = AppManager()
//    init(){
//        HomePage_Previews.manager.classes = [Class(name: "Mobile Apps", grade: 98.3, weight: 5, credits: 1.0), Class(name: "AP US History", grade: 78.3, weight: 6, credits: 1.0)]
//    }
    static var previews: some View {
        HomePage()
            .environmentObject(manager)
    }
}
