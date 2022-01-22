//
//  LoginPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import SwiftUI

struct LoginPage: View {
    
    @EnvironmentObject var manager: AppManager
    
    @State private var username = ""
    @State private var password = ""
    
    @KeychainStorage("username") var savedUsername = ""
    @KeychainStorage("password") var savedPassword = ""

    // TODO: Dynamically update list
    static let districts = ["Frisco ISD", "Plano ISD"]
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                
                Text(manager.error)
                
                GradualLogo()
                
                Text("Connect to your \nGrades")
                    .font(.largeTitle)
                
                VStack {
                    TextField("Username", text: $username)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $password)
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
                    
                    NavigationLink(destination: HomePage(), isActive: .constant(manager.student != nil)) {}
                    
                    Button {
                        
                    } label: {
                        Text("I'm a parent")
                            .foregroundColor(Color("GradGreen"))
                    }
                }
                Spacer()
                    .frame(minHeight: 150)
                
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .padding()
            .environmentObject(manager)
            
        }
        .navigationBarHidden(true)
        .onAppear(perform: {
            Task {
                do {
                    try await manager.loadData(username: savedUsername, password: savedPassword)
                } catch {
                    print("Unable to load data from Keynanchain")
                }
            }
        })
    }
    
    func loadData() async {
        savedUsername =  username
        savedPassword = password
        do {
            try await manager.loadData(username: username, password: password)
        } catch {
            manager.error = error.localizedDescription
            print(manager.error)
        }
    }
}


struct GradualLogo: View {
    var body: some View {
        HStack {
            Image(systemName: "graduationcap")
                .foregroundColor(Color("GradGreen"))
            Text("Gradual")
                .font(.title2)
        }
        .padding(.bottom, 5)
    }
}


struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
