//
//  LoginPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/3/22.
//

import SwiftUI

/// This allows the user to login to the app.
struct LoginPage: View {
    
    @EnvironmentObject var manager: AppManager
    @State private var username = ""
    @State private var password = ""
    @Binding var dataLoading: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(manager.error)
            
            GradualLogo()
            
            Text("Connect to your \nGrades")
                .font(.largeTitle)
            
            StudentCredentialsView(username: $username, password: $password, dataLoading: $dataLoading)
            
            Spacer()
                .frame(minHeight: 150)
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .padding()
    }
}


/// Allows the user to log into the app.
/// Makes a request to the AppManager with the student's credentials.
struct StudentCredentialsView: View {
    
    @EnvironmentObject var manager: AppManager
    @Binding var username: String
    @Binding var password: String
    @Binding var dataLoading: Bool

    var body: some View {
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
            
            
            Button {
                
            } label: {
                Text("I'm a parent")
                    .foregroundColor(Color("GradGreen"))
            }
        }
        
    }
    
    /// Helper function to load the student data.
    /// Calls the Manager's load data functions.
    /// Resets the username and password for security purposes.
    func loadData() async {
        do {
            try await manager.loadData(username: username, password: password, newSignIn: true)
            username = ""
            password = ""
            manager.error = ""
        } catch {
            manager.error = error.localizedDescription
            print(manager.error)
        }
    }
}

/// The app logo and name.
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


//
//struct LoginPage_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginPage()
//    }
//}
