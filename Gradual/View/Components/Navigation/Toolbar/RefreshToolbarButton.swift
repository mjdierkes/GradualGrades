//
//  RefreshToolButton.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/1/22.
//

import SwiftUI

struct RefreshToolButton: View {
    @EnvironmentObject var manager: AppManager

    var body: some View {
        AsyncButton(systemImageName: "arrow.clockwise", action: {
            do {
                try await manager.reload()
            } catch {
                print("Unable to reload")
            }
        })
            .tint(Color("Text"))
            .padding(.leading)
    }
}

struct RefreshToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        RefreshToolButton()
    }
}
