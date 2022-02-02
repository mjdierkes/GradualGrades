//
//  Upcoming.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/16/22.
//

import Foundation
import SwiftUI


/// Revives upcoming SATs from the server.
struct UpcomingSATs: Codable {
    var dates: [String]
    
    /// Sorts through all the SAT dates and finds the next one.
    var liveDates: [String]{
        var output = [String]()
        let dateFormatter = DateFormatter()
        let stringFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        stringFormatter.dateStyle = .full
        let today = Date()
        for date in dates {
            if let date = dateFormatter.date(from: date) {
                if date > today {
                    output.append(stringFormatter.string(from: date))
                }
            } else {
                print("Can not convert date\(date)")
            }
        }
        return output
    }
}
