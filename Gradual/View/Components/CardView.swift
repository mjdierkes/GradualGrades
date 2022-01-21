//
//  CardView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var manager: AppManager
    
    var body: some View {
        
        ZStack {
            Color("BackgroundGray")
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.white)
                
                VStack(alignment: .leading) {
                    Image("CollegeBoard-Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 25)
                    Text("Upcoming SAT \(manager.nextSAT)")
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
                        Text("5")
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

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
