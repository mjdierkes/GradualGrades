//
//  RecentAssignmentView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct RecentAssignmentView: View {

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Unit Circle Test")
                    .font(.headline)
                    .bold()
                Text("100%")
                    .foregroundColor(Color("GradGreen"))
                Spacer()
                Text("Pre Calculus")
                HStack {
                    Image(systemName: "arrowtriangle.up.fill")
                    Text("2.38 (5%)")
                }
                .foregroundColor(Color("GradGreen"))

            }
            
            Spacer()
        }
        .padding(15)
        .frame(width:150, height: 150)
        .cornerRadius(7)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("BorderGray"), lineWidth: 1)
        )
    }
}

struct RecentAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        RecentAssignmentView()
    }
}
