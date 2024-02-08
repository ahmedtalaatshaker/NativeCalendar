//
//  CalendarDataCodable.swift
//  
//
//  Created by Ahmed Talaat on 08/02/2024.
//

import Foundation

public struct CalendarData<T> {
    var date: Date!
    var events: [T]?
    
    public init(date: Date!, events: [T]? = nil) {
        self.date = date
        self.events = events
    }
}

public struct UserSelection<T> {
    public var dateUTC: TimeInterval!
    public var events: [T]?
}
