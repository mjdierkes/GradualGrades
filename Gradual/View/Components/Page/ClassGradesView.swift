//
//  ClassGradesView.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/1/22.
//

import SwiftUI

struct ClassGradesView: View {
    @EnvironmentObject var manager: AppManager

    var body: some View {
        Text("Grades")
            .padding()
            .font(.title2)
            .font(.system(.body, design: .rounded))
        
        ForEach($manager.classes) { details in
            NavigationLink(destination: AssignmentPage(classDetails: details)) {
                SimpleClassView(classData: details)
            }
            .tint(.black)
        }
    }
}

struct ClassGradesView_Previews: PreviewProvider {
    static var previews: some View {
        ClassGradesView()
    }
}
