//
//  CodableTypes.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation
import SwiftUI

/// All student information.
/// Helps make decisions on what content to show the user.
/// A middle school student will not be shown SAT dates.
struct Student: Codable {
    let birthdate: String
    let campus: String
    let grade: String
    let id: String
    let name: String
    
    var fullName: String {
        let lastName = name.components(separatedBy: ",")[0]
        let firstName = name.components(separatedBy: " ")[1]
        
        return firstName + " " + lastName
    }
    
    var longBirthdate: String {
        let dateFormatter = DateFormatter()
        let stringFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        stringFormatter.dateStyle = .medium
        
        if let date = dateFormatter.date(from: birthdate){
            return stringFormatter.string(from: date)
        }
        return birthdate
    }
    
    
}

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
    
    let formatter = GradeFormatter()

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

/// Manages what kind of grade the assignment is.
enum GradeType: String {
    case minor = "Minor Grades"
    case major = "Major Grades"
    case none  = "Non Graded"
}

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
                return String((score / totalPoints) * 100)
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

/// Revives upcoming SATs from the server.
struct UpcomingSATs: Codable {
    var dates: [String]
    
    /// Sorts through all the SAT dates and finds the next one.
    var liveDates: [String]{
        var output = [String]()
        let dateFormatter = DateFormatter()
        let stringFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        stringFormatter.dateStyle = .full
        let today = Date()
        for date in dates {
            if let date = dateFormatter.date(from: date) {
                if date > today {
                    output.append(stringFormatter.string(from: date))
                }
            } else {
                print("Can not convert date\(date)")
            }
        }
        return output
    }
    
}


/// Helps format how grades are displayed.
struct GradeFormatter {
    /// Returns a color based on the users score in that class.
    func getColor(from score: Double?) -> Color {
        if let score = score {
            switch score {
            case _ where score < 80:
                return Color("DefaultFailing")
                
            case _ where score < 90:
                return Color("Default-B")
                
            case _ where score < 100:
                return Color("GradGreen")
                
            default: return Color("PerfectlyInsane")
            }
        }
        return Color("PerfectlyInsane")
    }
    
    /// Calculates the new average score for assignments.
    /// This is used for the Doomsday calculator.
    ///
    /// Make sure to pass in Minor and Major grades separately.
    func getAverage(for assignments: [Assignment]) -> Double{
        var average: Double = 0
        var count = Double(assignments.count)
        
        for assessment in assignments {
            if let score = Double(assessment.score){
                average += score
            } else {
                count -= 1
            }
        }
        average /= count

        return average
    }
    
}


/// Helps remove decimals from grades.
extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
