//
//  RecentAssignmentStack.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/15/22.
//

import SwiftUI

struct RecentAssignmentStack: View {
    
    @EnvironmentObject var manager: AppManager

    var body: some View {
        
        Group {
            if manager.recentAssignments.count > 0 {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(manager.recentAssignments) { assessment in
                            RecentAssignmentView(className: assessment.className, assignment: assessment)
                        }
                    }
                }
                
            }
        }
        .edgesIgnoringSafeArea(.all)

        .padding()
       
        
    }
}

struct RecentAssignmentStack_Previews: PreviewProvider {
    static var previews: some View {
        RecentAssignmentStack()
    }
}
