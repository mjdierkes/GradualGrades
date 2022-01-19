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
    let studentBirthDate: String
    let studentBuilding: String
    let studentGrade: String
    let studentID: String
    let studentName: String
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
}

struct Assignment: Codable, Identifiable {
    
    let id = UUID()
    
    let dateDue: String
    let dateAssigned: String
    var assignment: String
    let category: String
    var score: String
    let totalPoints: String
    
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
