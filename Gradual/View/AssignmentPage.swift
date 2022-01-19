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
            
            if classDetails.assignments.count == 0 {
                Spacer()
                Text("No Assignments Yet")
                Spacer()
            }
            
            else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                                          
                        
                        if classDetails.getGrades(ofType: .major).count > 1{
                            Text("Major")
                                .font(.title2)
                                .bold()

                            ForEach(classDetails.getGrades(ofType: GradeType.major)) { assessment in
                                SimpleAssignmentView(assessment: assessment)
                            }
                            
                            Spacer()
                                .frame(height: 40)
                        }
                        
                        if classDetails.getGrades(ofType: .minor).count > 1{
                            Text("Minor")
                                .font(.title2)
                                .bold()
                        
                            ForEach(classDetails.getGrades(ofType: GradeType.minor)) { assessment in
                                SimpleAssignmentView(assessment: assessment)
                            }
                        }
                        
                        
    //                    Text("Information")
    //                        .font(.title3)
    //                        .padding(.top, 20)
    //                        .padding(.vertical, 20)
    //
    //                    VStack {
    //
    //                        HStack{
    //                            InfoDivider(key: "Credits", value: "1")
    //                            InfoDivider(key: "Weighting", value: "5.0")
    //                        }
    //                        HStack{
    //                            InfoDivider(key: "Period", value: "3B")
    //                            InfoDivider(key: "Room Number", value: "XC103")
    //                        }
    //                    }
                        
                    }
                    
                }
            }
           

        }
        .padding()
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


//struct AssignmentPage_Previews: PreviewProvider {
//    static var previews: some View {
//        AssignmentPage()
//    }
//}
