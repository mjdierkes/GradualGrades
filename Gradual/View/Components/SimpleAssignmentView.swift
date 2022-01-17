//
//  SimpleAssignmentView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/17/22.
//

import SwiftUI

struct SimpleAssignmentView: View {
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Optionals")
                Spacer()
                Text("85%")
                    .foregroundColor(Color("GradGreen"))
            }
            .padding(.vertical)
            Divider()
        }
        
    }
}

struct SimpleAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleAssignmentView()
    }
}
