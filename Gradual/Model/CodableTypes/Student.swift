//
//  Student.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/1/22.
//

import Foundation

/// All student information.
/// Helps make decisions on what content to show the user.
/// A middle school student will not be shown SAT dates.
struct Student: Codable {
    let birthdate: String
    let campus: String
    let grade: String
    let id: String
    let name: String
    
    /// Cleans up the name to remove the middle name.
    /// Makes the interface feel more connected to the user.
    /// This is used in the account page.
    var fullName: String {
        let lastName = name.components(separatedBy: ",")[0]
        let firstName = name.components(separatedBy: " ")[1]
        
        return firstName + " " + lastName
    }
    
    /// Reformats the users birthdate to display the month name.
    /// Used in the account page.
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

/// Wrapper for the class info.
/// Used to get all the class info from the API.
struct Schedule: Codable {
    let schedule: [ClassMeta]
}

/// The metadata for a class.
/// This is displayed under the assignments.
struct ClassMeta: Codable{
    let building: String
    let courseCode: String
    let courseName: String
    let days: String
    let markingPeriods: String
    let periods: String
    let room: String
    let status: String
    let teacher: String
}
