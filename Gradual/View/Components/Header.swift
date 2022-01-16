//
//  Header.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            ZStack{
                HStack {
                    Image(systemName: "star.circle.fill")
                    Text("Free Premium")
                }
                .foregroundColor(Color("GradGreen"))
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 15)
            .background(Color("LowGreen"))
            .cornerRadius(50)

            Spacer()
            Image(systemName: "bell")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
        }
        .scaleEffect(0.9)

    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
