//
//  Day.swift
//  NativeCalendarPOC
//
//  Created by Ahmed Talaat on 01/02/2024.
//

import Foundation
struct Day<T> {
    let date: Date
    let number: String
    var isSelected: Bool
    var isDateBetween: Bool
    let isWithinDisplayedMonth: Bool
    let isHaveEvents: Bool
    var cellIndex: Int
    var isOffDay: Bool
    var utc: TimeInterval
    var fromToLabel: String?
    var events: [T]?
    var isWeekend: Bool
}

