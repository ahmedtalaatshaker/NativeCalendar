//
//  CalendarMapper.swift
//  NativeCalendarPOC
//
//  Created by Ahmed Talaat on 01/02/2024.
//

import Foundation
public enum SelectionType {
    case single
    case multi
    case from_to
}

public enum dayWeek: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    
    var weekDays: [String] {
        switch self {
        case .sunday:
            return ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        case .monday:
            return ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
        case .tuesday:
            return ["Tue","Wed","Thu","Fri","Sat","Sun","Mon"]
        case .wednesday:
            return ["Wed","Thu","Fri","Sat","Sun","Mon","Tue"]
        case .thursday:
            return ["Thu","Fri","Sat","Sun","Mon","Tue","Wed"]
        case .friday:
            return ["Fri","Sat","Sun","Mon","Tue","Wed","Thu"]
        case .saturday:
            return ["Sat","Sun","Mon","Tue","Wed","Thu","Fri"]
        }
    }
}

enum Month {
    case next
    case previous
}

enum WeekIndex {
    case first
    case second
    case third
    case forth
    case fifth
    case sixth
    
    var range: CountableClosedRange<Int> {
        switch self {
        case .first:
            return 0...6
        case .second:
            return 7...13
        case .third:
            return 14...20
        case .forth:
            return 21...27
        case .fifth:
            return 28...34
        case .sixth:
            return 35...41
        }
    }
    
    var next: WeekIndex {
        switch self {
        case .first:
            return .second
        case .second:
            return .third
        case .third:
            return .forth
        case .forth:
            return .fifth
        case .fifth:
            return .sixth
        case .sixth:
            return .first
        }
    }
    
    var previous: WeekIndex {
        switch self {
        case .first:
            return .sixth
        case .second:
            return .first
        case .third:
            return .second
        case .forth:
            return .third
        case .fifth:
            return .forth
        case .sixth:
            return .fifth
        }
    }
}

public struct CalendarData {
    var date: Date!
    var events: [Dictionary<String, Any>]?
    
    public init(date: Date!, events: [Dictionary<String, Any>]? = nil) {
        self.date = date
        self.events = events
    }
}

public struct UserSelection {
    var dateUTC: TimeInterval!
    var events: [Dictionary<String, Any>]?
}
