//
//  AssignmentPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct AssignmentPage: View {
    
    @State private var calculatorDisabled = true
    @Binding var classDetails: Class
    @EnvironmentObject var manager: AppManager

    var body: some View {
        
        VStack {
            if classDetails.assignments.count == 0 {
                Spacer()
                Text("No Assignments Yet")
                Spacer()
            }
            
            else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Assignments(gradeType: .major, average: classDetails.majorAverage, assignments: classDetails.majorGrades, calculatorActive: $calculatorDisabled)
                        Assignments(gradeType: .minor, average: classDetails.minorAverage, assignments: classDetails.minorGrades, calculatorActive: $calculatorDisabled)
                    }
                    .padding()
                    Spacer()
                    ClassInformation(classDetails: $classDetails, calculatorActive: $calculatorDisabled)
                }
            }
        }
        .navigationBarTitle(classDetails.name)
        .navigationBarTitleDisplayMode(.inline)

    }
}

private struct Assignments: View {
    
    var gradeType: GradeType
    var average: Double?
    var assignments: [Assignment]
    @Binding var calculatorActive: Bool
    
    let formatter = GradeFormatter()
        
    
    var body: some View {
        if assignments.count > 1{
            
            HStack {
                Text((gradeType == .major) ? "Majors" : "Minors")
                    .font(.title2)
                    .bold()
                Spacer()
                
                if let average = average {
                    Text(String(average) + "%")
                        .foregroundColor(formatter.getColor(from: average))
                        .font(.title2)
                        .bold()
                }
            }
            .padding(.bottom)

            ForEach(assignments) { assessment in
//                                NavigationLink(destination: DetailedAssignmentPage(assessment: assessment)) {
                    SimpleAssignmentView(assessment: assessment, calculatorActive: $calculatorActive)
//                                }
                .tint(.black)
            }
            
            Spacer()
                .frame(height: 40)
        }
        
    }
}

//struct AssignmentPage_Previews: PreviewProvider {
//    static var previews: some View {
//        AssignmentPage()
//    }
//}
