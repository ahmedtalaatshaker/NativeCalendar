//
//  CalendarDayGeneration.swift
//  NativeCalendarPOC
//
//  Created by Ahmed Talaat on 01/02/2024.
//

import Foundation
// MARK: - Day Generation
extension CalendarView {
    
    func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
        guard let numberOfDaysInMonth = calendar.range(
            of: .day,
            in: .month,
            for: baseDate)?.count,
              let firstDayOfMonth = calendar.date(
                from: calendar.dateComponents([.year, .month], from: baseDate))
        else {
            throw CalendarDataError.metadataGeneration
        }
        
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        return MonthMetadata(
            numberOfDays: numberOfDaysInMonth,
            firstDay: firstDayOfMonth,
            firstDayWeekday: firstDayWeekday)
    }
    
    enum CalendarDataError: Error {
        case metadataGeneration
    }
    
    func generateDaysInMonth(for baseDate: Date) -> [Day] {
        guard let metadata = try? monthMetadata(for: baseDate) else {
            fatalError("An error occurred when generating the metadata for \(baseDate)")
        }
        
        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay
        
        var daysToAdd = 0
        
        if offsetInInitialRow - firstWeekDay.rawValue > 0 {
            daysToAdd = offsetInInitialRow - firstWeekDay.rawValue + 1
        }else if offsetInInitialRow - firstWeekDay.rawValue < 0 {
            daysToAdd = 8 - abs(offsetInInitialRow - firstWeekDay.rawValue)
        }else{
            daysToAdd = 1
        }
        
        var days: [Day] = (1..<(numberOfDaysInMonth + daysToAdd))
            .map { day in
                let isWithinDisplayedMonth = day >= daysToAdd
                let dayOffset = isWithinDisplayedMonth ? daysToAdd == 1 ? day - 1 : day - daysToAdd : -(daysToAdd - day)
                
                return generateDay(
                    offsetBy: dayOffset,
                    for: firstDayOfMonth,
                    isWithinDisplayedMonth: isWithinDisplayedMonth)
            }
        let daysInLastWeek = days.count % 7
        let remainningDays = 7 - daysInLastWeek
        
        if remainningDays < 7 {
            days += generateStartOfNextMonth(using: firstDayOfMonth, additionalDays: remainningDays)
        }
        
        return days
    }
    
    func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day {
        let date = calendar.date(
            byAdding: .day,
            value: dayOffset,
            to: baseDate) ?? baseDate
        
        return Day(
            date: date,
            number: dateFormatterShowDays.string(from: date),
            isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
            isWithinDisplayedMonth: isWithinDisplayedMonth,
            isHaveEvents: datesWithEvents.contains(date),
            cellIndex: 0,
            isOffDay: offDates.contains(date)
        )
    }
    
    func generateStartOfNextMonth(using firstDayOfDisplayedMonth: Date, additionalDays: Int) -> [Day] {
        
        guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfDisplayedMonth) else { return [] }
        
        let days: [Day] = (1...additionalDays).map {
            generateDay( offsetBy: $0, for: lastDayInMonth, isWithinDisplayedMonth: false)
        }
        return days
    }
}


