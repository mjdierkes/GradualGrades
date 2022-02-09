//
//  PreferencesView.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/2/22.
//

import SwiftUI

struct PreferencesView: View {
    
    @EnvironmentObject var manager: AppManager
    @EnvironmentObject var preferences: PreferencesManager
    @Environment(\.dismiss) var dismiss
    
//    @AppStorage("FaceID") var requireFaceID: Bool = false
    @AppStorage("StyleGrades") var styleGrades: Bool = true
    @AppStorage("ColorScheme") var preferredAppearance: Appearance = .light
    @State private var showingAlert = false
    @State private var selectedAppearance = 1
    
    
    var body: some View {
        
        
//            Section("Security") {
//                Toggle(isOn: $requireFaceID) {
//                    Text("Face ID")
//                }
//            }
            
            Section("Appearance") {
                Toggle(isOn: $styleGrades) {
                    Text("Style Grades")
                }
                Picker(selection: $selectedAppearance, label: Text("Appearance")) {
                    Text("System Default").tag(1)
                    Text("Light").tag(2)
                    Text("Dark").tag(3)
                }
                .onChange(of: selectedAppearance) { value in
                    print(selectedAppearance)
                    switch selectedAppearance {
                    case 1:
                        preferences.appearance = nil
                    case 2:
                        preferences.appearance = .light
                    case 3:
                        preferences.appearance = .dark
                    default:
                        break
                    }
                }
            }
            
            Section {
//                NavigationLink(destination: SplashScreen(), isActive: .constant(manager.student == nil)) { EmptyView() }

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
        
        .preferredColorScheme(preferences.appearance)
        .onChange(of: styleGrades) { _ in
            Task {
                try await manager.reload()
            }
        }
        .onAppear {
            switch preferences.appearance {
            case .none:
                selectedAppearance = 1
            case .light:
                selectedAppearance = 2
            case .dark:
                selectedAppearance = 3
            default:
                break
            }
        }
    }
    
    
    enum Appearance: String, Identifiable, CaseIterable {
        case light, dark, system
        
        var displayName: String { rawValue.capitalized }
        
        var id: String { self.rawValue }
    }
    
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
