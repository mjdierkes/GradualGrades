//
//  HomePage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading){
                    GreetingView()
                    CardStackView()
                    ClassGradesView()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                RefreshToolButton()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                AccountToolButton()
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color("Background"))
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct HomePage_Previews: PreviewProvider {
    @StateObject static var manager = AppManager()
    static var previews: some View {
        HomePage()
            .environmentObject(manager)
    }
}
