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
    
    init() {
        loadDefaults()
    }
    
    private func loadDefaults() {
        
        
        
    }
    
    
}
