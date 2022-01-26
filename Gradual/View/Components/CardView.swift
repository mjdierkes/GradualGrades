//
//  CardView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var manager: AppManager
    @State private var offset = CGSize.zero
    
    var removal: (() -> Void)? = nil

    var body: some View {
        
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color("Background"))
                
                VStack(alignment: .leading) {
                    Image("CollegeBoard-Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 25)
                    Text("Upcoming SAT \(manager.nextSAT)")
                        .font(.title2)
                    Spacer()
                    NavigationLink(destination: UpcomingAssignmentPage()) {
                        Text("Learn More")
                    }
                    .tint(Color("GradGreen"))
                }
                .padding(.vertical)
                .padding(.trailing, 19)
            }
            .padding()
            .rotationEffect(.degrees(Double(offset.width / 10)))
            .offset(x: offset.width * 1, y: 0)
            .opacity(2 - Double(abs(offset.width / 100)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        if abs(offset.width) > 100 {
                            removal?()
                        } else {
                            withAnimation {
                                offset = .zero
                            }
                        }
                    }
            )
//            VStack {
//                HStack {
//                    Spacer()
//                    ZStack {
//                        Circle()
//                            .frame(width: 30, height: 30)
//                            .foregroundColor(Color("GradGreen"))
//                        Text("5")
//                            .foregroundColor(Color.white)
//                            .bold()
//                    }
//                }
//                Spacer()
//            }
//            .offset(x: -8, y: 10)
        }
        
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
