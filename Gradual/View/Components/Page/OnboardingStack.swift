//
//  OnboardingStack.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/20/22.
//

import SwiftUI

struct OnboardingStack: View {
    
    var intros: [Intro]
    @Binding var index: Int
    
    var body: some View {
        VStack(spacing: 100) {
            Text("GRADUAL")
            Image(intros[index].image)
                .resizable().aspectRatio(contentMode: .fit)
                .frame(width: 250)
            
            VStack(spacing: 15) {
                Text(intros[index].title)
                    .font(.title)
                Text(intros[index].description)
                    .font(.body)
            }
          
            Button {
//                withAnimation {
                if index < intros.count - 1 {
                    index += 1
                }
//                }
            } label: {
                
                if index == intros.count - 1 {
                    Text("Get Started")
                        .frame(minWidth: 275, minHeight: 32)

                }
                else {
                    Text("Next")
                        .frame(minWidth: 275, minHeight: 32)
                }
                
            }
            .tint(.black)
            .buttonStyle(.borderedProminent)
        }
        .padding(25)
        .multilineTextAlignment(.center)

    }
}

//struct OnboardingStack_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingStack()
//    }
//}
