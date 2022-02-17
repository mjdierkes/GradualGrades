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
    
    let size = 150.0
    let formatter = GradeFormatter()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(assignment.assignment)
                    .font(.subheadline)
                    .bold()
                Text(assignment.calculatedScore)
                    .foregroundColor(assignment.scoreColor())
                    .font(.title)
                    .bold()

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
        .frame(width: size, height: size)
        .cornerRadius(7)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("BorderGray"), lineWidth: 1)
        )
    }
}

struct RecentAssignmentView_Previews: PreviewProvider {
    @StateObject static var manager = AppManager()
    static var assessment = Assignment(dateDue: "", dateAssigned: "", assignment: "Unit Circle Test", category: "Major", score: "100", totalPoints: "100")
    static var previews: some View {
        RecentAssignmentView(className: "Mobile App", assignment: assessment)
            .environmentObject(manager)
    }
}
