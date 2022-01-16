//
//  Class.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/15/22.
//

import Foundation

struct Classes: Codable {
    let current: [Class]
}

struct Class: Codable {
    let name: String
    let grade: Int
    let weight: Int
    let credits: Int
}
