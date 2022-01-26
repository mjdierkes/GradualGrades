//
//  LoadingPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/24/22.
//

import SwiftUI

struct LoadingPage: View {
    var body: some View {
        VStack {
            ProgressView()
        }
    }
}

struct LoadingPage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPage()
    }
}
