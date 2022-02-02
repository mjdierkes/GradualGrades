//
//  Assignment.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/1/22.
//

import Foundation
import SwiftUI

/// Holds the data for a class assignment.
struct Assignment: Codable, Identifiable {
    let id = UUID()
    
    let dateDue: String
    let dateAssigned: String
    var assignment: String
    let category: String
    var score: String
    let totalPoints: String
    
    let formatter = GradeFormatter()

    var gradeType: GradeType {
        GradeType(rawValue: category) ?? .none
    }
    
    /// Ensures every score is out of a 100 when
    /// teachers are lazy and put in how many you got correct.
    ///
    /// If the score can't be converted to a number it displays
    /// the original value.
    var calculatedScore: String {
        if let score = Double(score){
            if let totalPoints = Double(totalPoints){
                return String(((score / totalPoints) * 100).roundTo(places: 1))
            }
        }
        return score
    }
    
    /// Tries to convert the score and get the color.
    func scoreColor() -> Color {
        if let score = Double(calculatedScore) {
            return formatter.getColor(from: score)
        } else {
            return Color("EmptyGrade")
        }
    }
    
    /// Only these keys will be codable
    private enum CodingKeys: String, CodingKey {
        case dateDue, dateAssigned, assignment, category, score, totalPoints
    }
}


/// Manages what kind of grade the assignment is.
enum GradeType: String {
    case minor = "Minor Grades"
    case major = "Major Grades"
    case none  = "Non Graded"
}
