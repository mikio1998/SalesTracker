//
//  Date+.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/31.
//

import Foundation

extension Date {
    var currentHoursAndMins: (hours: Int, mins: Int) {
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        return (hours, minutes)
    }
}
