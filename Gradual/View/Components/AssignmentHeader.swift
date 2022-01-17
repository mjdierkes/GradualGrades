//
//  AssignmentHeader.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/17/22.
//

import SwiftUI

struct AssignmentHeader: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    var body: some View {
        HStack {
            
            Button{
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            }
            Spacer()
            Text("Mobile App")
                .font(.title3)
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                
            }
        }
        .tint(Color.black)
    }
}

struct AssignmentHeader_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentHeader()
    }
}
