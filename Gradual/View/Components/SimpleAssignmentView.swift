//
//  SimpleAssignmentView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/17/22.
//

import SwiftUI

struct SimpleAssignmentView: View {
    
    @Binding var name: String
    @Binding var score: String
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                Spacer()
                Text(score)
                    .foregroundColor(Color("GradGreen"))
            }
            .padding(.vertical, 5)
            Divider()
        }
        
    }
}

//struct SimpleAssignmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SimpleAssignmentView()
//    }
//}
