//
//  PreferencesManager.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/24/22.
//

import Foundation
import SwiftUI


class PreferencesManager: ObservableObject{
    
    @Published var requireFaceID = false
    @Published var showColors = true
    @Published var appearance: ColorScheme? = nil
    @Published var testGoal = "1600"
    
    init() {
        loadDefaults()
    }
    
    private func loadDefaults() {
        
        
        
    }
    
    
}
