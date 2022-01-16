//
//  Student.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/15/22.
//

import Foundation

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
