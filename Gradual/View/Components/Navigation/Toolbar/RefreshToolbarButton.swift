//
//  RefreshToolbarButton.swift
//  Gradual
//
//  Created by Mason Dierkes on 3/3/22.
//

import SwiftUI

struct RefreshToolButton: View {
    @EnvironmentObject var manager: AppManager

    var body: some View {
        
        Group {
            if manager.dataLoading {
                ProgressView()
            }
            else {
                AsyncButton(systemImageName: "arrow.clockwise", action: {
                    do {
                        try await manager.reload()
                    } catch {
                        print("Unable to reload")
                    }
                })
            }
        }
        .tint(Color("Text"))
        .padding(.leading)
       
       
    }
}


