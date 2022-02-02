//
//  GPA.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/1/22.
//

import Foundation


/// A wrapper that contains the students GPA.
struct GPA: Codable {
    let unweightedGPA: String
    let weightedGPA: String
    
    var roundedWeightedGPA: String {
        String(Double(weightedGPA)?.roundTo(places: 2) ?? 0)
    }
}

/// Wrapper object to send for Live GPA calculations.
struct LiveGPA: Codable {
    let weightedGPA: Double
    let unweightedGPA: Double
    let studentGrade: Int
    let classes: [Class]
}

/// Data received from the Live GPA calculations.
struct NewGPA: Codable {
    let finalWeightedGPA: String
    let finalUnweightedGPA: String
}
