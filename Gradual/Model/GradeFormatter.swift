//
//  GradeFormatter.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/1/22.
//

import Foundation
import SwiftUI

/// Helps format how grades are displayed.
struct GradeFormatter {
    /// Returns a color based on the users score in that class.
    func getColor(from score: Double?) -> Color {
        
        let defaults = UserDefaults()
        
        if let styleGrades = defaults.object(forKey: "StyleGrades"){
            if styleGrades as? Bool == false {
                return Color("Text")
            }
        }
         
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
            if let score = Double(assessment.calculatedScore){
                average += score
            } else {
                count -= 1
            }
        }
        average /= count
        

        return average
    }
    
    func getEditableAverage(for assignments: [Assignment]) -> Double{
        var average: Double = 0
        var count = Double(assignments.count)
        
        for assessment in assignments {
            if let score = Double(assessment.editableGrade){
                average += score
            } else {
                count -= 1
            }
        }
        average /= count
        

        return average.roundTo(places: 2)
    }
    
    
    /// Cleans up the class names by removing unnecessary info.
    func filter(name: String) -> String {
        var name = name
        var size = 0
        
        if name.contains("-") {
            name = String(name.components(separatedBy: "-")[1])
            size = name.count
            
            name = String(name.suffix(size - 6))
            size = name.count
            
            if name.contains("@CTE") {
                name = String(name.prefix(size - 7))
            }
            
            else if name.contains("S2") || name.contains("S1"){
                name = String(name.prefix(size - 2))
            }
        }
       
        
        return name
    }
    
}


/// Helps remove decimals from grades.
extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
