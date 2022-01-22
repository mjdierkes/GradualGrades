//
//  ParentalControls.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/19/22.
//

import Foundation

/// Adds extra features for parents with multiple students.
struct Parent {
    var accounts = [Account]()
}

/// Holds the credentials for each user.
struct Account {
    var name: String
    let username: String
    let password: String
}
