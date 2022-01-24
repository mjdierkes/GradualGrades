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
    @State private var preferences = PreferencesManager()
    @State private var showingAlert = false
    
    var body: some View {
        
        NavigationView {
            VStack {
               

                Form {
                    
                    NavigationLink(destination: AccountDetailPage()) {
                        ZStack {
                            VStack {
                                Circle()
                                    .frame(width: 75, height: 75)
                                
                                if let student = manager.student {
                                    Text(student.fullName)
                                        .font(.title2.weight(.semibold))
                                    Text("Student")
                                }
                               
                            }
                            .frame(height: 175)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        }
                    }
                    

//                    Section("Security") {
//                        Toggle(isOn: $preferences.requireFaceID) {
//                            Text("Face ID")
//                        }
//
//                    }
//
//                    Section("Appearance") {
//
//                        Toggle(isOn: $preferences.showColors) {
//                            Text("Style Grades")
//                        }
                        
//                        Picker("Appearance", selection: $preferences.appearance) {
//                            ForEach(Appearance.allCases) { section in
//                                Text(section.displayName)
//                                    .tag(section)
//                            }
//                        }
                        
                        
                        
//
//                    }
//
//                    Section("Accounts") {
//
//                        HStack {
//                            Text("Mason Dierkes")
//                            Spacer()
//                            Text("Signed In")
//                                .foregroundColor(Color("BorderGray"))
//                        }
//
//                        HStack {
//                            Text("John Doe")
//                            Spacer()
//                            Button {
//
//                            } label: {
//                                Text("Sign In")
//                                    .foregroundColor(Color("GradGreen"))
//                            }
//                        }
//
//                    }
                
                    Section {
                        Button {
                            showingAlert = true
                        } label: {
                            Text("Sign out")
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)

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
                    }
                    
                    
                }
            }
            .navigationTitle("Account")
        }
        
        
        
        
        
    }
}

enum Appearance: String, Identifiable, CaseIterable {
    case light, dark, system
    
    var displayName: String { rawValue.capitalized }
    
    var id: String { self.rawValue }
}
    

struct UserPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}
