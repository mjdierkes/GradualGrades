//
//  AccountPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/17/22.
//

import SwiftUI

struct AccountPage: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var manager: AppManager
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
                .tint(.black)
            }
            
            Spacer()
            NavigationLink(destination: LoginPage(), label: {
                Button {
                    manager.signOut()
                    dismiss()
                } label: {
                    Text("Sign Out")
                }
            })
            Spacer()
        }
        .padding()
    }
}

struct UserPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}
