//
//  ContentView.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/15/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var gradeService = GradeService(username: "john", password: "doe")
    
    var body: some View {
        VStack {
            Text("Hello, \(gradeService.result?.studentData.studentName ?? "ERROR")")
                .padding()
        }
        .task {
            try? await gradeService.fetchUser()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
