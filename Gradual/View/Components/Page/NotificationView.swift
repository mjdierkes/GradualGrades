//
//  NotificationView.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/3/22.
//

import Popovers
import SwiftUI

struct NotificationViewPopover: View {
    var body: some View {
        HStack {
            Image(systemName: "wifi.exclamationmark")
                .foregroundColor(Color.white)
            Text("No internet connection")
                .foregroundColor(Color.white)
            Spacer()
        }
        .frame(maxWidth: 600)
        .padding()
        .padding(.vertical, 2)
        .background(Color("DarkGray"))
        .opacity(0.98)
        .cornerRadius(12)
    }
}
