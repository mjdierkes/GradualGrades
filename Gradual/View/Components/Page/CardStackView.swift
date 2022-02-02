//
//  CardStackView.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/1/22.
//

import SwiftUI

struct CardStackView: View {
    
    @EnvironmentObject var manager: AppManager
    
    var body: some View {
        if manager.cards.count > 0 {
            ZStack {
                Color("BackgroundGray")
                ForEach(0..<manager.cards.count, id: \.self) { index in
                    CardView() {
                        withAnimation {
                            manager.removeCard(at: index)
                        }
                    }
                }
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
