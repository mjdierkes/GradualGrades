//
//  CodableTypes.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation
import SwiftUI

// TODO: Refactor and clean up codable objects



struct Student: Codable {
    let birthdate: String
    let campus: String
    let grade: String
    let id: String
    let name: String
}

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

    private enum CodingKeys: String, CodingKey {
        case name, grade, weight, credits, assignments
    }
    
    func getColor() -> Color {
        
        if let score = Double(grade) {
            switch score {
            case _ where score < 80:
                return Color("DefaultFailing")
                
            case _ where score < 90:
                return Color("Default-B")
                
            case _ where score < 100:
                return Color("GradGreen")
                
            default: return Color.blue
            }
        }
        
        return Color("EmptyGrade")

    }
    
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

struct Assignment: Codable, Identifiable {
    
    let id = UUID()
    
    let dateDue: String
    let dateAssigned: String
    var assignment: String
    let category: String
    var score: String
    let totalPoints: String
    
    var gradeType: GradeType {
        GradeType(rawValue: category) ?? .none
    }
    
    private enum CodingKeys: String, CodingKey {
        case dateDue, dateAssigned, assignment, category, score, totalPoints
    }
    
    func getColor() -> Color {
        
        if let score = Double(score) {
            switch score {
            case _ where score < 80:
                return Color("DefaultFailing")
                
            case _ where score < 90:
                return Color("Default-B")
                
            case _ where score < 110:
                return Color("GradGreen")
                
            default: return Color.blue
            }
        }
        
        return Color("EmptyGrade")
        
    }
}

enum GradeType: String {
    case minor = "Minor Grades"
    case major = "Major Grades"
    case none  = "Non Graded"
}
