//
//  CodableTypes.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation
import SwiftUI

// TODO: Refactor and clean up codable objects


struct Result: Codable {
    var studentData: Student
}

struct Student: Codable {
    let studentID: String
    let studentName: String
    let studentBirthDate: String
    let studentCounselor: String
    let studentBuilding: String
    let studentGrade: String
}

struct Classes: Codable {
    let currentClasses: [Class]
}

struct Class: Codable, Identifiable {
    let id = UUID()
    
    var name: String
    let grade: Double
    let weight: Int
    let credits: Double
    
    private enum CodingKeys: String, CodingKey {
        case name, grade, weight, credits
    }
}

struct AllGrades: Codable {
    let currentClassDetails: [ClassDetails]
}

struct ClassDetails: Codable, Identifiable {
    let id = UUID()
    
    var className: String
    let classGrade: String
    var assignments: [Assignment]
    
    private enum CodingKeys: String, CodingKey {
        case className, classGrade, assignments
    }
    
    func getColor() -> Color {
        
        if let score = Double(classGrade) {
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
        
        return Color.black
        
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
        
        return Color.black
        
    }
}
