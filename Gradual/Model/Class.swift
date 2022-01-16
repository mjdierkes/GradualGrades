//
//  Class.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/15/22.
//

import Foundation

struct Classes: Codable {
    let currentClasses: [Class]
}

struct Class: Codable {
    let name: String
    let grade: Double
    let weight: Int
    let credits: Int
}
