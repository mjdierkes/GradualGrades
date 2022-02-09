//
//  AccountToolButton.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/1/22.
//

import SwiftUI

struct AccountToolButton: View {
    @EnvironmentObject var manager: AppManager

    var body: some View {
        Button {
            manager.showingAccountPage.toggle()
        } label: {
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
        }
        .tint(Color("Text"))
        .scaleEffect(0.9)
        .padding(.trailing)
        .sheet(isPresented: $manager.showingAccountPage){
            AccountPage()
        }

    }
}

struct AccountToolButton_Previews: PreviewProvider {
    static var previews: some View {
        AccountToolButton()
    }
}
