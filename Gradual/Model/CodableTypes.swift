//
//  CodableTypes.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation

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

struct Class: Codable {
    let name: String
    let grade: Double
    let weight: Int
    let credits: Double
}

struct AllGrades: Codable {
    let currentClassDetails: [ClassDetails]
}

struct ClassDetails: Codable {
    let className: String
    let classGrade: String
    let assignments: [Assignment]
}

struct Assignment: Codable {
    let dateDue: String
    let dateAssigned: String
    let assignment: String
    let category: String
    let score: String
    let totalPoints: String
}
