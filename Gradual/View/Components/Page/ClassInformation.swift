//
//  ClassInformation.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/3/22.
//

import SwiftUI
import MapKit

struct ClassInformation: View {
    
    @Binding var classDetails: Class
    @EnvironmentObject var doomManager: DoomsdayManager
    
    var body: some View {
        VStack(alignment: .leading) {

            HStack(alignment: .center) {
                
                Text("Information")
                    .font(.title3)
                    .padding(.bottom)
                
                Spacer()
                
                if classDetails.assignments.count > 0 {
                    ZStack{
                        Button {
                            doomManager.calculatorActive.toggle()
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        } label: {
                            Text((doomManager.calculatorActive) ? "Doomsday Calculator" : "Close Calculator")
                                .font(.system(size: 14))
                                .foregroundColor(Color("GradGreen"))
                        }
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color("LowGreen"))
                    .cornerRadius(50)
                }
            }
            
            

            
            if let meta = classDetails.meta {
                InfoDivider(key: "Teacher", value: meta.teacher.capitalized, spacer: false)
                InfoDivider(key: "Building", value: meta.building, spacer: false)
                HStack{
                    InfoDivider(key: "Period", value: meta.periods + meta.days)
                    InfoDivider(key: "Room Number", value: meta.room)
                }
            }
            
            HStack{
                InfoDivider(key: "Credits", value: classDetails.credits)
                InfoDivider(key: "Weighting", value: classDetails.weight)
            }
          
           
        }
        .padding()
        .padding(.vertical, 5)
    }
}


struct InfoDivider: View {
    
    let key: String
    let value: String
    var spacer: Bool = true
    
    var body: some View {
        VStack{
            HStack {
                Text(key)
                    .foregroundColor(Color("BorderGray"))
                    .font(.system(size: 16))
                    .padding(.trailing, (spacer) ? 0 : 20)
                if spacer {
                    Spacer()
                }
                
                if value == "CTE"{
                    Button {
                        let coordinate = CLLocationCoordinate2DMake(33.126738, -96.796412)
                        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
                        mapItem.name = "CTE Center"
                        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
                    } label:  {
                        Text(value + " Center")
                            .tint(Color("GradGreen"))
                    }
                } else {
                    Text(value)
                        .font(.system(size: 16))
                }
                
                if !spacer {
                    Spacer()
                }
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
