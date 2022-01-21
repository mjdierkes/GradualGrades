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
            
            AssignmentHeader(classDetails: $classDetails)
                .padding()
            
            if classDetails.assignments.count == 0 {
                Spacer()
                Text("No Assignments Yet")
                ClassInformation()
                Spacer()
            }
            
            else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                                          
                        
                        if classDetails.getGrades(ofType: .major).count > 1{
                            Text("Majors")
                                .font(.title2)
                                .bold()

                            ForEach(classDetails.getGrades(ofType: GradeType.major)) { assessment in
                                SimpleAssignmentView(assessment: assessment)
                            }
                            
                            Spacer()
                                .frame(height: 40)
                        }
                        
                        if classDetails.getGrades(ofType: .minor).count > 1{
                            Text("Minors")
                                .font(.title2)
                                .bold()
                        
                            ForEach(classDetails.getGrades(ofType: GradeType.minor)) { assessment in
                                SimpleAssignmentView(assessment: assessment)
                            }
                        }
                        
                    }
                    .padding()
                    ClassInformation()
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
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
    
    var body: some View {
        VStack(alignment: .leading) {

            Text("Information")
                .font(.title3)
                .padding(.bottom)
            
            HStack{
                InfoDivider(key: "Credits", value: "1")
                InfoDivider(key: "Weighting", value: "5.0")
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
