//
//  AssignmentPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct AssignmentPage: View {
    
    @Binding var classDetails: Class
    @EnvironmentObject var manager: AppManager

    var body: some View {
        
        VStack {
            
            if classDetails.assignments.count == 0 {
                Spacer()
                Text("No Assignments Yet")
//                ClassInformation(classDetails: $classDetails)
                Spacer()
            }
            
            else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                                          
                        
                        if classDetails.majorGrades.count > 1{
                            
                            HStack {
                                Text("Majors")
                                    .font(.title2)
                                    .bold()
                                Spacer()
                                if let average = classDetails.majorAverage {
                                    Text(String(average) + "%")
                                        .foregroundColor(classDetails.majorColor())
                                        .font(.title2)
                                        .bold()
                                }
                                

                            }
                            .padding(.bottom)

                            

                            ForEach(classDetails.majorGrades) { assessment in
//                                NavigationLink(destination: DetailedAssignmentPage(assessment: assessment)) {
                                    SimpleAssignmentView(assessment: assessment)
//                                }
                                .tint(.black)
                            }
                            
                            Spacer()
                                .frame(height: 40)
                        }
                        
                        if classDetails.minorGrades.count > 1{
                            HStack  {
                                Text("Minors")
                                    .font(.title2)
                                    .bold()
                                Spacer()
                                if let average = classDetails.minorAverage {
                                    Text(String(average) + "%")
                                        .foregroundColor(classDetails.minorColor())
                                        .font(.title2)
                                        .bold()
                                }
                                
                            }
                            .padding(.bottom)
                            
                        
                            ForEach(classDetails.minorGrades) { assessment in
//                                NavigationLink(destination: DetailedAssignmentPage(assessment: assessment)) {
                                    SimpleAssignmentView(assessment: assessment)
//                                }
                                .tint(.black)
                            }
                        }
                        
                    }
                    .padding()
//                    ClassInformation(classDetails: $classDetails)
                }
            }
        }
        .navigationBarTitle(classDetails.name)
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
}

struct InfoDivider: View {
    
    let key: String
    let value: String
    
    var body: some View {
        VStack{
            HStack(alignment: .center){
                Text(key)
                    .foregroundColor(Color("BorderGray"))
                    .font(.system(size: 16))
                Spacer()
                Text(value)
                    .font(.system(size: 16))
            }
            Divider()
        }
    }
}


struct ClassInformation: View {
    
    @Binding var classDetails: Class
    var body: some View {
        VStack(alignment: .leading) {

            HStack(alignment: .center) {
                
                Text("Information")
                    .font(.title3)
                    .padding(.bottom)
                
                Spacer()
                
                ZStack{
                    Button {
                        
                    } label: {
                        Text("Doomsday Calculator")
                            .font(.system(size: 14))
                            .foregroundColor(Color("GradGreen"))
                    }
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color("LowGreen"))
                .cornerRadius(50)
            }
            
            
            HStack{
                InfoDivider(key: "Credits", value: classDetails.credits)
                InfoDivider(key: "Weighting", value: classDetails.weight)
            }
            HStack{
                InfoDivider(key: "Period", value: "3B")
                InfoDivider(key: "Room Number", value: "XC103")
            }
        }
        .padding()
        .padding(.vertical, 5)
    }
}


//struct AssignmentPage_Previews: PreviewProvider {
//    static var previews: some View {
//        AssignmentPage()
//    }
//}
