//
//  AssignmentPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct AssignmentPage: View {
    
    @Binding var classDetails: ClassDetails
    @EnvironmentObject var manager: AppManager

    var body: some View {
        
        VStack {
            
            AssignmentHeader(classDetails: $classDetails)
            

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                                            
                         
                    ForEach($classDetails.assignments) { assessment in
                        SimpleAssignmentView(assessment: assessment)
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
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)

        }
        .padding()

                
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
