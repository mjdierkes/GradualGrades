//
//  DoomsdayManager.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/5/22.
//

import Foundation

class DoomsdayManager: ObservableObject {
    @Published var overallAverage: String = ""
    
    var majorAverage: Double? = 0
    var minorAverage: Double? = 0
    
    @Published var editableMajor: Double? = 0
    @Published var editableMinor: Double? = 0
    
    @Published var majorAssignments = [Assignment]()
    @Published var minorAssignments = [Assignment]()
    @Published var calculatorActive = true
    
    let formatter = GradeFormatter()
    
    func build(from classDetails: Class){
        overallAverage = classDetails.grade
        
        majorAverage = classDetails.majorAverage
        minorAverage = classDetails.minorAverage
        editableMajor = majorAverage
        editableMinor = minorAverage
        majorAssignments = classDetails.majorGrades
        minorAssignments = classDetails.minorGrades
    }
    
    
    func getOverallAverage() -> Double {
        var output = 0.0
        
        if let editableMajor = editableMajor {
            output += editableMajor * 0.6
        }
        if let editableMinor = editableMinor {
            output += editableMinor * 0.4
        }
        
        return output
    }
    
    
    func calculateAverages() {
        editableMajor = formatter.getEditableAverage(for: majorAssignments)
        editableMinor = formatter.getEditableAverage(for: minorAssignments)
        overallAverage = String(getOverallAverage())
    }
    
    
}

