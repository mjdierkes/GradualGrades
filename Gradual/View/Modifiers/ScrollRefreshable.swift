//
//  ScrollRefreshable.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/12/22.
//

import SwiftUI

import SwiftUI

// Note it will use Apple's Refreshable Modifier...
// Not any from UIKit...

struct ScrollRefreshable<Content: View>: View {
    
    var content: Content
    var onRefresh: () async ->()
    
    init(@ViewBuilder content: @escaping ()->Content,onRefresh: @escaping () async ->()){
        
        self.content = content()
        self.onRefresh = onRefresh
        
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        
        List{
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color("Background"))
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .refreshable {
            await onRefresh()
        }
    }
}
