//
//  Header.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct Header: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        HStack {
            ZStack{
                Button {
                    showingSheet.toggle()
                } label: {
                    HStack {
                        Image(systemName: "star.circle.fill")
                        Text("Free Premium")
                            .font(.system(size: 14))
                    }
                    .foregroundColor(Color("GradGreen"))
                }
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(Color("LowGreen"))
            .cornerRadius(50)

            Spacer()
            Image(systemName: "bell")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
        }
        .scaleEffect(0.9)
        .sheet(isPresented: $showingSheet){
            PremiumPage()
        }

    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
