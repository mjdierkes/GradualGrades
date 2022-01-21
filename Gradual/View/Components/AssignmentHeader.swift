//
//  AssignmentHeader.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/17/22.
//

import SwiftUI

struct AssignmentHeader: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var classDetails: Class

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
            Text(classDetails.name)
                .font(.title3)
                .multilineTextAlignment(.center)
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "gearshape")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
            }
        }
        .tint(Color.black)
    }
}

//struct AssignmentHeader_Previews: PreviewProvider {
//    static var previews: some View {
////        AssignmentHeader()
//    }
//}
