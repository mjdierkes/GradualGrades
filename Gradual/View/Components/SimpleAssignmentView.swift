//
//  SimpleAssignmentView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/17/22.
//

import SwiftUI

struct SimpleAssignmentView: View {
    
    var assessment: Assignment
    
    var body: some View {
        VStack {
            HStack {
                Text(assessment.assignment)
                Spacer()
                Text(assessment.calculatedScore + ((Double(assessment.calculatedScore) ?? 0 > 0) ? "%" : " "))
                    .foregroundColor(assessment.getColor())
            }
            .padding(.vertical, 7)
            Divider()
        }
        
    }
}

//struct SimpleAssignmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SimpleAssignmentView()
//    }
//}
