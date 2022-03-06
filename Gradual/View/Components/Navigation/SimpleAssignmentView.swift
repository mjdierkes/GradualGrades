//
//  SimpleAssignmentView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/17/22.
//

import SwiftUI

struct SimpleAssignmentView: View {
    
    @State private var color = Color.black
    @Binding var assessment: Assignment
    @EnvironmentObject var doomManager: DoomsdayManager
    
    var isEditable = true
    let formatter = GradeFormatter()
    
    var body: some View {
        VStack {
            HStack {
                Text(assessment.assignment)
                    .foregroundColor(Color("Text"))
                Spacer()
//                Text(assessment.calculatedScore + ((Double(assessment.calculatedScore) ?? 0 > 0) ? "%" : " "))
//                    .foregroundColor(assessment.scoreColor())
                
                HStack {
                    if !doomManager.calculatorActive && assessment.gradeType != .none {
                        TextField((!doomManager.calculatorActive && assessment.editableGrade == "") ? "Score" : "", text: $assessment.editableGrade)
                            .padding(.horizontal)
                            .background((!doomManager.calculatorActive && isEditable) ? Color("BackgroundGray") : Color("Background"))
                            .cornerRadius(7)
                            .keyboardType(.numberPad)
                            .fixedSize()
                            .disabled(doomManager.calculatorActive && isEditable)
                    }
                    else {
                        Text((Double(assessment.editableGrade) ?? 0 > 0) ? "\(assessment.editableGrade)%" : " ")
                            .padding(1)
                    }
                }
                .foregroundColor(color)
            }
            .padding(.vertical, 7)
            .onChange(of: assessment.editableGrade) { newValue in
                if let newValue = Int(newValue) {
                    color = formatter.getColor(from: Double(newValue))
                    doomManager.calculateAverages()
                } else {
                    print("Could not convert to int")
                }
            }
            .onChange(of: doomManager.calculatorActive) { newValue in
                assessment.editableGrade = assessment.calculatedScore
                
                color = assessment.scoreColor()
            }
            .onAppear {
                color = assessment.scoreColor()
                assessment.editableGrade = assessment.calculatedScore
            }
            Divider()
        }
        
    }
}

//struct SimpleAssignmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SimpleAssignmentView()
//    }
//}
