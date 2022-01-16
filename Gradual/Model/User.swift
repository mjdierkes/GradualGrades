//
//  User.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/15/22.
//

import Foundation

struct User: Codable {
    let student: Student
    let classes: [Class]
}
