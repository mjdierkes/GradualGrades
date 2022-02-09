//
//  ClassWidgetView.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/8/22.
//

import SwiftUI

struct ClassWidgetView: View {
    
    @StateObject var manager = AppManager()
    
    var body: some View {
        ZStack {
            if let student = manager.student {
                Text("Hello, \(student.fullName)")
            } else {
                Text("Your Logged Now")
            }
        }
        .onAppear(perform: {
            Task {
                do {
                    try await manager.reload()
                } catch {
                    print("Unable to load data from Keynanchain")
                }
            }
        })
        
    }
}

struct ClassWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        ClassWidgetView()
    }
}
