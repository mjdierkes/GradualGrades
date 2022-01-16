//
//  SimpleClassView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct SimpleClassView: View {
    
    @Binding var classData: Class
    
    var body: some View {
        VStack {
            HStack {
                Text(classData.name)
                Spacer()
                Text(String(classData.grade))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 23)
                    .padding(.vertical, 6)
                    .background(Color("GradGreen"))
                    .cornerRadius(7)
            }
            Divider()
        }
        .padding()
    }
}

struct SimpleClassView_Previews: PreviewProvider {
    
    @State static private var classData = Class(name: "Mobile Apps", grade: 98.3, weight: 5, credits: 1)
    
    static var previews: some View {
        SimpleClassView(classData: $classData)
    }
}
