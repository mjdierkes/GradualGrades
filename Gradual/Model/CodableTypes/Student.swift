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

struct Schedule: Codable {
    let schedule: [ClassMeta]
}

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
