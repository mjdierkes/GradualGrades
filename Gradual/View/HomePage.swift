//
//  HomePage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct HomePage: View {
    
    @EnvironmentObject var manager: AppManager

    var body: some View {
        
        VStack {
            if let student = manager.student {
                Text(student.studentName)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
