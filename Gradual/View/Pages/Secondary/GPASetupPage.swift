//
//  GPASetupPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 3/8/22.
//

import SwiftUI

struct GPASetupPage: View {
    
    @EnvironmentObject var manager: AppManager

    var body: some View {
        VStack {
            ForEach(manager.classes) { classDetails in
                Text(classDetails.weight)
            }
        }
    }
}

struct GPASetupPage_Previews: PreviewProvider {
    static var previews: some View {
        GPASetupPage()
    }
}
