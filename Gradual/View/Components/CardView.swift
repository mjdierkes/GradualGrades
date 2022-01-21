//
//  CardView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        
        ZStack {
            
            
            Color("BackgroundGray")

            ZStack {
                
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.white)
                

                VStack(alignment: .leading) {
                    
                   
                    
                    
                    Text("Upcoming SAT March 14th at Frisco High School")
                        .font(.title2)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Learn More")
                    }
                    .tint(Color("GradGreen"))
                }
                .padding(.vertical)
                .padding(.trailing, 19)
               
            }
            .padding()
            
            VStack {
                HStack {
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("GradGreen"))
                        
                        Text("3")
                            .foregroundColor(Color.white)
                            .bold()
                        
                    }
                    

                }
                Spacer()
            }
            .offset(x: -8, y: 10)
            
            
        }
        .background(Color("BackgroundGray"))
        .frame(height: 200)

    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
