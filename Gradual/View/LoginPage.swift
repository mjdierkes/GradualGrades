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
    
    /// For testing purposes
    @State private var username = "john"
    @State private var password = "doe"
    
    // TODO: Dynamically update list
    static let districts = ["Frisco ISD", "Plano ISD"]
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                
                Text(manager.error)
                
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
                    
    
                    AsyncButton("Sign In", action: loadData)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                        .tint(.black)
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    
                    NavigationLink(destination: HomePage(), isActive: .constant(manager.student != nil)) {
                        
                    }

                    Button {
                        
                    } label: {
                        Text("Don't see your district?")
                            .foregroundColor(Color("GradGreen"))
                    }
                }
                Spacer()
                    .frame(minHeight: 150)

            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .padding()

        }



        
    }
    
    func loadData() async {
        do {
            try await manager.loadData(username: username, password: password)
        } catch {
            manager.error = error.localizedDescription
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
