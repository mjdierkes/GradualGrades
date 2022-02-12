//
//  DetailedAssignmentPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/21/22.
//

import SwiftUI

struct DetailedAssignmentPage: View {
    
    @Binding var assessment: Assignment
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text(assessment.assignment)
                .font(.title)
                .bold()
            Text(assessment.dateDue)
            
            HStack {
                
                Spacer()
                
                Text(assessment.calculatedScore)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("GradGreen"))
            }
            
            Spacer()
            
//            Text("Recommended Videos")
//                .font(.title2)
//            Text("Here are some tutorials that we think we could help.")
//                .font(.subheadline)
//            
//            Spacer(minLength: 75)
            
        }
        .padding()
    }
}

//struct DetailedAssignmentPage_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedAssignmentPage()
//    }
//}
