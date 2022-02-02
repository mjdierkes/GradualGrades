//
//  Class.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/1/22.
//

import Foundation
import SwiftUI

/// Wrapper for all of the students classes.
struct Classes: Codable {
    let currentClasses: [Class]
}

struct Class: Codable, Identifiable {
    let id = UUID()
    
    var name: String
    let grade: String
    let weight: String
    let credits: String
    var assignments: [Assignment]
    var roomNumber: String?
    
    let formatter = GradeFormatter()
    let defaults = UserDefaults()

    var majorGrades: [Assignment] {
        return getGrades(ofType: .major)
    }
    
    var minorGrades: [Assignment] {
        return getGrades(ofType: .minor)
    }
    
    var majorAverage: Double? {
        let average = formatter.getAverage(for: majorGrades).roundTo(places: 2)
        if average.isNaN{
            return nil
        }
        return average
    }
    
    var minorAverage: Double? {
        let average = formatter.getAverage(for: minorGrades).roundTo(places: 2)
        if average.isNaN {
            return nil
        }
        return average
    }
    
    var roundedGrade: String {
        if let score = Double(grade){
            if score >= 100 {
                return String(Int(score.roundTo(places: 0)))
            }
            return String(score.roundTo(places: 2))
        }
        return grade
    }
    private enum CodingKeys: String, CodingKey {
        case name, grade, weight, credits, assignments
    }
    
    func scoreColor() -> Color {
        if let score = Double(grade) {
            return formatter.getColor(from: score)
        } else {
            return Color("EmptyGrade")
        }
    }
    
    func minorColor() -> Color {
        formatter.getColor(from: minorAverage)
    }
    func majorColor() -> Color {
        formatter.getColor(from: majorAverage)
    }
    
    func textColor() -> Color {
        if let styleGrades = defaults.object(forKey: "StyleGrades"){
            if styleGrades as? Bool == false {
                return Color("FlippedText")
            }
            else {
                return Color("FlippedText")
            }
        }
        return Color("Text")
    }
    
    /// Separates minor grades from major grades.
    func getGrades(ofType type: GradeType) -> [Assignment] {
        var output = [Assignment]()
        for assessment in assignments {
            if assessment.gradeType == type {
                output.append(assessment)
            }
        }
        return output
    }
}
