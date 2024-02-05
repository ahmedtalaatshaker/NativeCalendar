//
//  CollectionViewDelegate.swift
//  NativeCalendarPOC
//
//  Created by Ahmed Talaat on 01/02/2024.
//

import UIKit

// MARK: - UICollectionViewDataSource
@available(iOS 13.0, *)
extension CalendarView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        daysToBeShown.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var day = daysToBeShown[indexPath.row]
        // TODO: here is the error
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarDayCell", for: indexPath) as! CalendarDayCell
        cell.setColors(defaultLabelColor: defaultLabelColor,
                       selectedLabelColor: selectedLabelColor,
                       offDaysColor: offDaysColor,
                       selectedBGColor: selectedBGColor)
        cell.setupView()
        day.cellIndex = indexPath.row
        cell.setDay(day: day, isMonthView: isMonthView)
        if day.isSelected {
            selectedDateCell = cell
        }
        guard let labelText = day.fromToLabel else { return cell }
        cell.setFromTo(text: labelText)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
@available(iOS 13.0, *)
extension CalendarView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defer {
            getSelectedDate(userSelectedDate)
        }
        
        var index = indexPath.row
        if !isMonthView {
            let currentRange = Array(weekIndex.range)
            index = currentRange[indexPath.row]
        }
        let currentDay = days[index]
        if currentDay.isOffDay { return }
        if days[index].isSelected {
            if selectionType == .from_to {
                deselectFromToType(for: index)
            } else {
                days[index].isSelected = false
                userSelectedDate.removeAll(where: {$0 == days[index].date.timeIntervalSince1970})
            }
            
        } else {
            switch selectionType {
            case .single:
                applySingleSelection(for: index)
            case .multi:
                applyMultiSelection(for: index)
            case .from_to:
                applyFromToSelection(for: index)
            }
        }
        
        if !days[index].isWithinDisplayedMonth && isMonthView{
            index < 7 ? moveToMonth(month: .previous) :  moveToMonth(month: .next)
        }
        reloadCollectionView()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width / 7)
        let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate
        return CGSize(width: width, height: height)
    }
    
    private func applySingleSelection(for index: Int) {
        days = setNotSelected(days: days)
        days[index].isSelected = true
        userSelectedDate = [days[index].date.timeIntervalSince1970]
    }
    
    private func applyMultiSelection(for index: Int) {
        days[index].isSelected = true
        userSelectedDate.append(days[index].date.timeIntervalSince1970)
    }

    private func applyFromToSelection(for index: Int) {
        if userSelectedDate.count < 2 {
            days[index].isSelected = true
            userSelectedDate.append(days[index].date.timeIntervalSince1970)

            if userSelectedDate.count == 2 {
                days = generateDaysInMonth(for: baseDate)
                for dayIndex in 0..<days.count where days[dayIndex].utc == userSelectedDate[0] {
                    days[dayIndex].fromToLabel = "From"
                }
                
                for dayIndex in 0..<days.count where days[dayIndex].utc == userSelectedDate[1] {
                    days[dayIndex].fromToLabel = "To"
                }

            }
        }
    }

    private func deselectFromToType(for index: Int) {
        if userSelectedDate.contains(days[index].utc) {
            userSelectedDate.removeAll(where: {$0 == days[index].date.timeIntervalSince1970})
            days = setNotSelected(days: days)
            if !userSelectedDate.isEmpty {
                for dayIndex in 0..<days.count where days[dayIndex].utc == userSelectedDate[0] {
                    days[dayIndex].isSelected = true
                }
            }
        }
    }
    
    
}
