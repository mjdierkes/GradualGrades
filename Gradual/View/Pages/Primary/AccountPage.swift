//
//  AccountPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/17/22.
//

import SwiftUI

/// Displays the users current settings.
struct AccountPage: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HeaderView()
                    PreferencesView()
                }
            }
        }
    }
    
}

/// Header for the Account Page.
/// Allows the user to navigate out of the page.
/// Displays more details like student info too.
private struct HeaderView: View {
    
    @EnvironmentObject var manager: AppManager

    var body: some View {
        if let student = manager.student {
            ZStack {
                VStack {
                    HStack{
                        InfoDivider(key: "Student ID", value: student.id)
                        InfoDivider(key: "Grade", value: student.grade)
                    }

                    InfoDivider(key: "Campus", value: student.campus)
                    InfoDivider(key: "Birthdate", value: student.longBirthdate)
                }
                .padding(.vertical)
                .frame(height: 175)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            .navigationTitle(student.fullName)
        }
    }
    
}

struct UserPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}
