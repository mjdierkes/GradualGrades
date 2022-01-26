//
//  PreferencesManager.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/24/22.
//

import Foundation


class PreferencesManager: ObservableObject{
    
    @Published var requireFaceID = false
    @Published var showColors = true
    @Published var appearance = Appearance.light
    @Published var testGoal = "1600"
    
    init() {
        loadDefaults()
    }
    
    private func loadDefaults() {
        
        
        
    }
    
    
}
