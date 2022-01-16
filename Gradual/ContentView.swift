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
            if let student = gradeService.student {
                Text(student.studentName)
            }
        }
        .task {
            try? await gradeService.fetchData()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
