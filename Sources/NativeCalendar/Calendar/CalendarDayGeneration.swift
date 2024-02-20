//
//  CalendarDayGeneration.swift
//  NativeCalendarPOC
//
//  Created by Ahmed Talaat on 01/02/2024.
//

import Foundation
// MARK: - Day Generation
@available(iOS 13.0, *)
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
    
    func generateDaysInMonth(for baseDate: Date) -> [Day<Codable>] {
        guard let metadata = try? monthMetadata(for: baseDate) else {
            fatalError("An error occurred when generating the metadata for \(baseDate)")
        }
        
        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay
        
        let daysToAdd = calculateUpper_LowerDates(offsetInInitialRow: offsetInInitialRow)
                
        var days: [Day<Codable>] = prepareDate(numberOfDaysInMonth: numberOfDaysInMonth, daysToAdd: daysToAdd, firstDayOfMonth: firstDayOfMonth)
        
        let daysInLastWeek = days.count % 7
        let remainningDays = 7 - daysInLastWeek
        
        if remainningDays < 7 {
            days += generateStartOfNextMonth(using: firstDayOfMonth, additionalDays: remainningDays)
        }
        setFromToLabel(days: &days)
        return days
    }
    
    private func calculateUpper_LowerDates(offsetInInitialRow: Int) -> Int{
        if offsetInInitialRow - firstWeekDay.rawValue > 0 {
            return offsetInInitialRow - firstWeekDay.rawValue + 1
        }else if offsetInInitialRow - firstWeekDay.rawValue < 0 {
            return 8 - abs(offsetInInitialRow - firstWeekDay.rawValue)
        }else{
            return 1
        }
    }
    
    private func prepareDate(numberOfDaysInMonth: Int, daysToAdd: Int, firstDayOfMonth: Date) -> [Day<Codable>] {
        return (1..<(numberOfDaysInMonth + daysToAdd))
            .map { day in
                let isWithinDisplayedMonth = day >= daysToAdd
                let dayOffset = isWithinDisplayedMonth ? daysToAdd == 1 ? day - 1 : day - daysToAdd : -(daysToAdd - day)
                
                return generateDay(
                    offsetBy: dayOffset,
                    for: firstDayOfMonth,
                    isWithinDisplayedMonth: isWithinDisplayedMonth)
            }
    }
    
    func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day<Codable> {
        let date = calendar.date(
            byAdding: .day,
            value: dayOffset,
            to: baseDate) ?? baseDate
        
        userSelectedDate.sort(by: {$0.dateUTC < $1.dateUTC})
        
        return Day(
            date: date,
            number: dateFormatterShowDays.string(from: date),
            isSelected: selectSameDate(date: date),
            isDateBetween: selectDateBetweenFrom_To(date: date),
            isWithinDisplayedMonth: isWithinDisplayedMonth,
            isHaveEvents: datesWithEvents.contains(where: {$0.date == date && $0.events != nil}),
            cellIndex: 0,
            isOffDay: offDates.contains(date), 
            utc: date.timeIntervalSince1970,
            events: datesWithEvents.first(where: {$0.date == date})?.events,
            isWeekend: isWeekendDay(for: date)
        )
    }
    
    private func isWeekendDay(for date: Date) -> Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        for day in weekend {
            if dayInWeek.contains(day.day) {
                return true
            }
        }
        return false
    }
    
    func generateStartOfNextMonth(using firstDayOfDisplayedMonth: Date, additionalDays: Int) -> [Day<Codable>] {
        
        guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfDisplayedMonth) else { return [] }
        
        let days: [Day] = (1...additionalDays).map {
            generateDay( offsetBy: $0, for: lastDayInMonth, isWithinDisplayedMonth: false)
        }
        return days
    }
    
    func selectSameDate(date: Date) -> Bool {
        for selectedDateUTC in userSelectedDate {
            let selectedDate = Date(timeIntervalSince1970: selectedDateUTC.dateUTC)
            if calendar.isDate(date, inSameDayAs: selectedDate) {
                return true
            }
        }
        return false
    }
    
    func selectDateBetweenFrom_To(date: Date) -> Bool {
        if selectionType == .from_to &&
            userSelectedDate.count == 2 {
            let selectedDateFrom = Date(timeIntervalSince1970: userSelectedDate[0].dateUTC)
            let selectedDateTo = Date(timeIntervalSince1970: userSelectedDate[1].dateUTC)
            return date < selectedDateTo && date > selectedDateFrom
        }
        return false
    }
}


