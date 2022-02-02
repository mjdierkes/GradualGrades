//
//  AccountDetailPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/24/22.
//

import SwiftUI

struct AccountDetailPage: View {
    
    @EnvironmentObject var manager: AppManager

    var body: some View {
        if let student = manager.student {
            VStack {
                HStack{
                    InfoDivider(key: "Student ID", value: student.id)
                    InfoDivider(key: "Grade", value: student.grade)
                }

                InfoDivider(key: "Campus", value: student.campus)
                InfoDivider(key: "Birthdate", value: student.longBirthdate)
            }
            .padding()
        }
    }
}

struct AccountDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailPage()
    }
}
