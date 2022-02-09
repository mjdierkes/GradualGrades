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
    var plainAverage: Double? = 0

    @Published var editableMajor: Double? = 0
    @Published var editableMinor: Double? = 0
    @Published var editablePlain: Double? = 0
    
    @Published var majorAssignments = [Assignment]()
    @Published var minorAssignments = [Assignment]()
    @Published var nonAssignments = [Assignment]()
    
    @Published var calculatorActive = true
    
    let formatter = GradeFormatter()
    
    func build(from classDetails: Class){
        overallAverage = classDetails.grade
        
        majorAverage = classDetails.majorAverage
        minorAverage = classDetails.minorAverage
        plainAverage = classDetails.nonAverage
        
        editableMajor = majorAverage
        editableMinor = minorAverage
        editablePlain = plainAverage
        
        majorAssignments = classDetails.majorGrades
        minorAssignments = classDetails.minorGrades
        nonAssignments = classDetails.nonGrades
    }
    
    
    func getOverallAverage() -> Double {
        var output = 0.0
        
        guard let editableMajor = editableMajor else {
            return output
        }
        guard let editableMinor = editableMinor else {
            return output
        }
        
        output += editableMajor * 0.6
        output += editableMinor * 0.4
        
        if editableMinor.isNaN && editableMajor.isNaN {
            return output
        }
        
        if editableMajor.isNaN {
            return editableMinor
        }
        
        if editableMinor.isNaN {
            return editableMajor
        }
        
        return output.roundTo(places: 2)
    }
    
    
    func calculateAverages() {
        editableMajor = formatter.getEditableAverage(for: majorAssignments)
        editableMinor = formatter.getEditableAverage(for: minorAssignments)
        overallAverage = String(getOverallAverage())
    }
    
    
}

