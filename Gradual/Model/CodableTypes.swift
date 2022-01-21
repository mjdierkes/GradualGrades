//
//  CodableTypes.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation
import SwiftUI

struct Student: Codable {
    let birthdate: String
    let campus: String
    let grade: String
    let id: String
    let name: String
}

struct GPA: Codable {
    let unweightedGPA: String
    let weightedGPA: String
    
    var roundedWeightedGPA: String {
        String(Double(weightedGPA)?.roundTo(places: 2) ?? 0)
    }
}

struct Classes: Codable, Hashable {
    let currentClasses: [Class]
}

struct Class: Codable, Identifiable, Hashable {
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

struct Assignment: Codable, Identifiable, Hashable {
    
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
    
    var calculatedScore: String {
        let newScore = Double(score) ?? 0
        let totalPoints = Double(totalPoints) ?? 0
        let calculatedScore = (newScore / totalPoints) * 100
        return String(calculatedScore.roundTo(places: 0))
    }
    
    private enum CodingKeys: String, CodingKey {
        case dateDue, dateAssigned, assignment, category, score, totalPoints
    }
    
    func getColor() -> Color {
        
        if let score = Double(calculatedScore) {
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

struct UpcomingSATs: Codable {
    var dates: [String]
    
    var liveDates: [String]{
        var output = [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let stringFormatter = DateFormatter()
        stringFormatter.dateStyle = .full
        let today = Date()
        print(today)
        for date in dates {
            if let date = dateFormatter.date(from: date) {
                if date > today {
                    output.append(stringFormatter.string(from: date))
                }
                print(date)
            } else {
                print("Can not convert date\(date)")
            }
        }
        return output
    }
    
}


enum GradeType: String {
    case minor = "Minor Grades"
    case major = "Major Grades"
    case none  = "Non Graded"
}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
