//
//  ClassInformation.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/3/22.
//

import SwiftUI


struct ClassInformation: View {
    
    @Binding var classDetails: Class
    @Binding var calculatorActive: Bool
    
    var body: some View {
        VStack(alignment: .leading) {

            HStack(alignment: .center) {
                
                Text("Information")
                    .font(.title3)
                    .padding(.bottom)
                
                Spacer()
                
                ZStack{
                    Button {
                        calculatorActive.toggle()
                    } label: {
                        Text((calculatorActive) ? "Doomsday Calculator" : "Done")
                            .font(.system(size: 14))
                            .foregroundColor(Color("GradGreen"))
                    }
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color("LowGreen"))
                .cornerRadius(50)
            }
            
            
            HStack{
                InfoDivider(key: "Credits", value: classDetails.credits)
                InfoDivider(key: "Weighting", value: classDetails.weight)
            }
            HStack{
                InfoDivider(key: "Period", value: "3B")
                InfoDivider(key: "Room Number", value: "XC103")
            }
        }
        .padding()
        .padding(.vertical, 5)
    }
}


struct InfoDivider: View {
    
    let key: String
    let value: String
    
    var body: some View {
        VStack{
            HStack(alignment: .center){
                Text(key)
                    .foregroundColor(Color("BorderGray"))
                    .font(.system(size: 16))
                Spacer()
                Text(value)
                    .font(.system(size: 16))
            }
            Divider()
        }
    }
}

//struct ClassInformation_Previews: PreviewProvider {
//    static var previews: some View {
//        ClassInformation()
//    }
//}
