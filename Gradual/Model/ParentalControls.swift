//
//  Parent.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/19/22.
//

import Foundation

struct Parent {
    var accounts = [Account]()
}

struct Account {
    var name: String
    let username: String
    let password: String
}
