//
//  About.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/21/22.
//

import SwiftUI

struct About: View {
    var body: some View {
        
        VStack {
            VStack(alignment: .leading, spacing: 15){
                
                GradualLogo()
                
                Text("An easy way to manage your school work")
                    .font(.largeTitle)
                    
                Text("Everything you could ever need from a grade app and more.")
                
                Spacer()
                
               
                
            }
            
            Button {
                
            } label: {
                Text("Get Started")
                    .font(.headline)
                    .frame(maxWidth: 300)
                    .padding(.vertical, 10)
            }
            .tint(.black)
            .buttonStyle(.borderedProminent)
        }
        .padding()

        
        
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
