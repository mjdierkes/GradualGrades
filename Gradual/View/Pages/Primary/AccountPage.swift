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
                .navigationTitle("Account")
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
        NavigationLink(destination: AccountDetailPage()) {
            ZStack {
                VStack {
                    Circle()
                        .frame(width: 75, height: 75)
                    
                    if let student = manager.student {
                        Text(student.fullName)
                            .font(.title2.weight(.semibold))
                        Text("Student")
                    }
                    
                }
                .frame(height: 175)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
        }
    }
    
}

struct UserPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}
