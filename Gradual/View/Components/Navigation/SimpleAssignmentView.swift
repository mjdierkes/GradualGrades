//
//  SimpleAssignmentView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/17/22.
//

import SwiftUI

struct SimpleAssignmentView: View {
    
    var assessment: Assignment
    @State private var text = "98"
    @State private var color = Color.black
    @Binding var calculatorActive: Bool
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
                    TextField("", text: $text)
                        .keyboardType(.numberPad)
                        .fixedSize()
                        .disabled(calculatorActive)
                    Text("%")
                }
                .foregroundColor(color)
            }
            .padding(.vertical, 7)
            .onChange(of: text) { newValue in
                if let newValue = Int(newValue) {
                    color = formatter.getColor(from: Double(newValue))
                } else {
                    print("RIPPP")
                }
            }
            .onAppear {
                color = assessment.scoreColor()
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
