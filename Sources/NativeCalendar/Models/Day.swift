//
//  Day.swift
//  NativeCalendarPOC
//
//  Created by Ahmed Talaat on 01/02/2024.
//

import Foundation
struct Day {
    let date: Date
    let number: String
    var isSelected: Bool
    let isWithinDisplayedMonth: Bool
    let isHaveEvents: Bool
    var cellIndex: Int
    var isOffDay: Bool
    var utc: TimeInterval
}

