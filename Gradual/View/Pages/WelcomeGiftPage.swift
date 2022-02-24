//
//  WelcomeGiftPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/21/22.
//

import SwiftUI

struct WelcomeGiftPage: View {
    
    @State private var phoneNumber = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        VStack(spacing: 50) {
            Image("Gift")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
            
            VStack(spacing: 10) {
                Text("Welcome to Gradual")
                    .font(.title).fontWeight(.semibold)
                Text("Enter for a chance to win a $100 Amazon gift card. It's our way of saying thanks.")
            }
            
            TextField("Phone Number", text: $phoneNumber)
                .textContentType(.telephoneNumber)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.phonePad)
                        
            VStack(spacing: 15) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                        .frame(minWidth: 275, minHeight: 32)
                }
                .tint(.black)
                .buttonStyle(.borderedProminent)
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("No thanks")
                }
                Text("We will only use this information \nto contact you if you win.")
            }
            
            Spacer()
            
        }
        .padding(25)
        .multilineTextAlignment(.center)
        
    }
    
}

struct WelcomeGiftPage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeGiftPage()
    }
}
