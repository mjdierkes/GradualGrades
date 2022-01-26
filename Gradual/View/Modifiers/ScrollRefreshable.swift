//
//  ScrollRefreshable.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/26/22.
//

import SwiftUI

struct ScrollRefreshable<Content: View>: View {
    
    var content: Content
    var onRefresh: () async ->()
    init(title: String, tintColor: Color, content: @escaping () -> Content, onRefresh: @escaping () async ->()){
        self.content = content()
        self.onRefresh = onRefresh
        
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: title)
        UIRefreshControl.appearance().tintColor = UIColor(tintColor)
    }
    
    var body: some View {
        List {
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .refreshable {
            await onRefresh()
        }
    }
}

struct ScrollRefreshable_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
