//
//  DetailedAssignmentPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/21/22.
//

import SwiftUI

struct DetailedAssignmentPage: View {
    
    var assessment: Assignment
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text(assessment.assignment)
                .font(.title)
                .bold()
            Text(assessment.dateDue)
            
            HStack {
                
                
                ZStack{
                    
                    Text("Better than 80%")
                        .font(.system(size: 14))
                        .foregroundColor(Color("GradGreen"))
                    
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color("LowGreen"))
                .cornerRadius(50)
                
                
                Spacer()
                
                Text(assessment.calculatedScore)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("GradGreen"))
                
                
                
            }
            
            Spacer()
            
            Text("Recommended Videos")
                .font(.title2)
            Text("Here are some tutorials that we think we could help.")
                .font(.subheadline)
            
            Spacer(minLength: 75)
            
        }
        .padding()
    }
}

//struct DetailedAssignmentPage_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedAssignmentPage()
//    }
//}
