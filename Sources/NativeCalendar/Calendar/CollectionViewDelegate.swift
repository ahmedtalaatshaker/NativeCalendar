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
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
@available(iOS 13.0, *)
extension CalendarView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var index = indexPath.row
        if !isMonthView {
            let currentRange = Array(weekIndex.range)
            index = currentRange[indexPath.row]
        }
        let currentDay = days[index]
        if currentDay.isOffDay { return }
        if days[index].isSelected {
            if selectionType == .from_to &&
                userSelectedDate.contains(days[index].utc) {
                userSelectedDate.removeAll(where: {$0 == days[index].date.timeIntervalSince1970})
                days = setNotSelected(days: days)
                if !userSelectedDate.isEmpty {
                    for dayIndex in 0..<days.count where days[dayIndex].utc == userSelectedDate[0] {
                        days[dayIndex].isSelected = true
                    }
                }
            } else {
                days[index].isSelected = false
                userSelectedDate.removeAll(where: {$0 == days[index].date.timeIntervalSince1970})
            }
            getSelectedDate(userSelectedDate)

        } else {
            switch selectionType {
            case .single:
                days = setNotSelected(days: days)
                days[index].isSelected = true
                userSelectedDate = [days[index].date.timeIntervalSince1970]
                getSelectedDate(userSelectedDate)
                
            case .multi:
                days[index].isSelected = true
                userSelectedDate.append(days[index].date.timeIntervalSince1970)
                getSelectedDate(userSelectedDate)
                
                break
            case .from_to:
                if userSelectedDate.count < 2 {
                    days[index].isSelected = true
                    userSelectedDate.append(days[index].date.timeIntervalSince1970)
                    getSelectedDate(userSelectedDate)
                }
                
                break
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
}
