//
//  CardStackView.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/1/22.
//

import SwiftUI

struct CardStackView: View {
    
    @EnvironmentObject var manager: AppManager
    @StateObject var model = UIStateModel()

    var body: some View {
        if manager.cards.count > 0 {
            
            ZStack {
                
                Color("BackgroundGray")

                SnapCarousel(items: $manager.cards)
                    .environmentObject(model)
                    .frame(height: 180)

                
            }
            .frame(height: 200)
            
        }
    }
}



struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
    }
}
