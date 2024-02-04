//
//  File.swift
//  
//
//  Created by Ahmed Talaat on 04/02/2024.
//

import Foundation
struct Helpers {
    static var shared = Helpers()
    func getDate(dateString: [String]) -> [Date] {
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
