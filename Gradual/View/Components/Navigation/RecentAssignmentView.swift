//
//  RecentAssignmentView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct RecentAssignmentView: View {

    @EnvironmentObject var manager: AppManager
    var className: String
    var assignment: Assignment
    
    let size = 170.0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(assignment.assignment)
                    .bold()
                Text(assignment.score)
                    .foregroundColor(Color("GradGreen"))
                    .font(.system(size: 16))

                Spacer()
                Text(className)
                    .bold()
                    .font(.system(size: 14))
                    .padding(.bottom, 2)
                HStack {
                    Image(systemName: "arrowtriangle.up.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                    
                    Text("2.38 (5%)")
                        .font(.system(size: 16))
                }
                .foregroundColor(Color("GradGreen"))
            }
            Spacer()
        }
        .padding(15)
        .frame(width: 170, height: 170)
        .cornerRadius(7)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("BorderGray"), lineWidth: 1)
        )
    }
}

//struct RecentAssignmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecentAssignmentView()
//    }
//}
