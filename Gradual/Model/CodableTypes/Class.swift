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

/// Holds all the data for required for a class.
//  TODO: Possibly refactor view code out to separate struct?
struct Class: Codable {
    var name: String
    var rawName: String
    let grade: String
    let weight: String
    let credits: String
    var assignments: [Assignment]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rawName = try container.decode(String.self, forKey: .name)
        grade = try container.decode(String.self, forKey: .grade)
        weight = try container.decode(String.self, forKey: .weight)
        credits = try container.decode(String.self, forKey: .credits)
        assignments = try container.decode([Assignment].self, forKey: .assignments)
        
        let formatter = GradeFormatter()
        name = formatter.filter(name: rawName)
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case name, grade, weight, credits, assignments
    }
    
    var meta: ClassMeta?
    
    // MARK: Formatting for View
    let formatter = GradeFormatter()
    let dateFormatter = DateFormatter()
    let defaults = UserDefaults()
    let cache = CacheService()
    
    /// Easy access for this classes major and minor grades.
    /// This is used in the Assignments Page.
    var majorGrades: [Assignment] {
        return getGrades(ofType: .major)
    }
    var minorGrades: [Assignment] {
        return getGrades(ofType: .minor)
    }
    var nonGrades: [Assignment] {
        return getGrades(ofType: .none)
    }
    
    /// Averages all the user's assignments to get average by type.
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
    var nonAverage: Double? {
        let average = formatter.getAverage(for: nonGrades).roundTo(places: 2)
        if average.isNaN {
            return nil
        }
        return average
    }
    /// Cleans up and formats the grade for displaying.
    var roundedGrade: String {
        if let score = Double(grade){
            //            cache.save(data: grade, forKey: name + "- Average")
            //            print(name, "- Average")
            if score >= 100 {
                return String(Int(score.roundTo(places: 0)))
            }
            return String(score.roundTo(places: 2))
        }
        return grade
    }
    
    func getPercentChange() -> Double? {
        print(name, "- Average")
        if let previousScore: Double = cache.load(forKey: name + "- Average") {
            if let score = Double(grade) {
                return ((score - previousScore) / previousScore) * 100
            }
        }
        return nil
    }
    
    /// Provides the view a color based on the class average.
    func scoreColor() -> Color {
        if let score = Double(grade) {
            return formatter.getColor(from: score)
        } else {
            return Color("EmptyGrade")
        }
    }
    
    /// Gets the color form the minor average.
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
    
    func getGradualAverage() -> [Double]{
        //        var dates = [(Date, Assignment)]()
        //        var currentDate: Date
        //
        //        for assessment in assignments {
        //            if let date = dateFormatter.date(from: assessment.dateDue) {
        //                dates.append((date, assessm
        //            } else {
        //                print("Unable to convert date")
        //            }
        //        }
        //
        //        for date in dates {
        //
        //        }
        //
        
        
        
        
        
        
        return [Double]()
    }
    
    
    
    
    public func getAssessmentDates() -> [Date] {
        var dates = [Date]()
        for assessment in assignments {
            if let date = dateFormatter.date(from: assessment.dateDue) {
                dates.append(date)
            }
        }
        return dates.sorted()
    }
}

extension Class: Identifiable {
    var id: Int { return name.hashValue }
}
