//
//  PremiumPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/17/22.
//

import SwiftUI

struct PremiumPage: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color("GradGreen")
                .ignoresSafeArea()

            VStack {
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

                Text("Premium")
                    .font(.title2)
                Text("It's amazing buy it!")
                Spacer()
            }
            .foregroundColor(Color.white)
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct PremiumPage_Previews: PreviewProvider {
    static var previews: some View {
        PremiumPage()
    }
}
