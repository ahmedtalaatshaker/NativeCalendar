//
//  CalendarHelpersMethods.swift
//  NativeCalendarPOC
//
//  Created by Ahmed Talaat on 01/02/2024.
//

import Foundation
@available(iOS 13.0, *)
extension CalendarView {
    
    private func getMonthWith(value: Int) -> Date{
        let selectedDate = self.calendar.date(
            byAdding: .month,
            value: value,
            to: self.baseDate) ?? self.baseDate
        if selectedDate >= startDate && selectedDate < endDate {
            return selectedDate
        }
        return baseDate
    }
    
    func moveToMonth(month: Month){
        defer {
            reloadCollectionView()
        }

        if isMonthView {
            baseDate = getMonthWith(value: month == .next ? 1 : -1)
        }else{
            if month == .next {
                if weekIndex == .sixth {
                    weekIndex = .second
                    baseDate = getMonthWith(value: 1)
                    
                }else if weekIndex == .fifth {
                    if numOfWeeksInMonth() == 5 {
                        weekIndex = .first
                        for day in daysToBeShown where !day.isWithinDisplayedMonth {
                            weekIndex = weekIndex.next
                            break
                        }
                        let nextMonth = getMonthWith(value: 1)
                        if nextMonth != baseDate {
                            baseDate = nextMonth
                        }else{
                            weekIndex = .fifth
                        }
                    }else{
                        weekIndex = weekIndex.next
                    }
                }else {
                    weekIndex = weekIndex.next
                }
            }else{
                if weekIndex != .first {
                    weekIndex = weekIndex.previous
                }else{
                    if getMonthWith(value: -1) == baseDate {
                        return
                    } else{
                        baseDate = getMonthWith(value: -1)
                    }
                    weekIndex = numOfWeeksInMonth() == 5 ? .fifth : .sixth
                    for day in daysToBeShown where !day.isWithinDisplayedMonth {
                        weekIndex = weekIndex.previous
                        break
                    }
                }
            }
        }
    }
    
    func numOfWeeksInMonth() -> Int{
        days.count / 7
    }
    
    func setNotSelected(days: [Day<Codable>]) -> [Day<Codable>]{
        return days.map { day in
            var _day = day
            _day.isSelected = false
            _day.isDateBetween = false
            _day.fromToLabel = nil
            return _day
        }
    }
}
