//
//  AccountPage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/17/22.
//

import SwiftUI

struct AccountPage: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var manager: AppManager
    
    @State private var faceID = false
    @State private var showingAlert = false
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading){
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                    .tint(.black)
                }
                
                
                Text("Hi \(manager.student?.fullName ?? "ERROR")")
                    .font(.title)
                
                Spacer()
                
                Text("Security")
                    .font(.title2)
                
                VStack {
                    Toggle("Face ID", isOn: $faceID)
                    Divider()
                }
                .padding(.bottom)
                
                
                HStack {
                    Text("Accounts")
                        .font(.title2)
                    
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Add Account")
                    }
                    .tint(Color("GradGreen"))
                }
                
                VStack {
                    HStack {
                        Text("Mason Dierkes")
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Sign In")
                        }
                        .tint(Color("GradGreen"))
                    }
                    Divider()
                    HStack {
                        Text("John Doe")
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Signed In")
                        }
                        .tint(Color("BorderGray"))
                    }
                    Divider()
                }
                .padding(.vertical)
                
            }
            
            if let student = manager.student {
                VStack {
                    HStack{
                        InfoDivider(key: "Student ID", value: student.id)
                        InfoDivider(key: "Grade", value: student.grade)
                    }
                        
                    InfoDivider(key: "Campus", value: student.campus)
                    InfoDivider(key: "Birthdate", value: student.longBirthdate)
                }
                .padding(.vertical)
            }
            
            
            NavigationLink(destination: LoginPage(), label: {
                Button {
                    showingAlert = true
                } label: {
                    Text("Sign out")
                }
                .tint(.red)
                .alert(isPresented:$showingAlert) {
                    Alert(
                        title: Text("Are you sure you want to sign out?"),
                        primaryButton: .destructive(Text("Sign out")) {
                            manager.signOut()
                            dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
            })
            
           
           
            
        }
        
        .padding()
    }
}

//struct UserPage_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountPage()
//    }
//}
