//
//  LoginPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct LoginPage: View {
    
    @EnvironmentObject var manager: AppManager
    
    @State private var selectedDistrict = ""
    @State private var username = ""
    @State private var password = ""
    
    // TODO: Dynamically update list
    static let districts = ["Frisco ISD", "Plano ISD"]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            if let student = manager.student {
                Text("Hello, \(student.studentName)!")
            }
            
            HStack {
                Image(systemName: "graduationcap")
                    .foregroundColor(Color("GradGreen"))
                Text("Gradual")
                    .font(.title2)
            }
            .padding(.bottom, 5)
            
            Text("Connect to your \nGrades")
                .font(.largeTitle)

            Picker("District", selection: $selectedDistrict) {
                ForEach(LoginPage.districts, id: \.self){
                    Text($0)
                }
            }
            
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                TextField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.password)
                    .padding(.bottom, 60)
                
                Button {
                    Task {
                        await manager.loadData(username: username, password: password)
                    }
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .frame(maxWidth: 300)
                }
                .padding(.vertical)
                .tint(.black)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
                
                Button {
                    
                } label: {
                    Text("Don't see your district?")
                        .foregroundColor(Color("GradGreen"))
                }
            }

            Spacer()
        }
        .padding()
        
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
