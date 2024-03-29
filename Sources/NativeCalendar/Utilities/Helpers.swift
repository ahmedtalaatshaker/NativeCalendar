//
//  File.swift
//  
//
//  Created by Ahmed Talaat on 04/02/2024.
//

import UIKit
public struct Helpers {
    public static var shared = Helpers()
    
    /// Dates must be in "dd/MM/yyyy" Format
    public func getDate(dateString: [String]) -> [Date] {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.dateFormat = "dd/MM/yyyy"

        var dates = [Date]()
        dateString.forEach {
            dates.append(dateFormatter.date(from: $0) ?? Date())
        }
        return dates
    }
}
