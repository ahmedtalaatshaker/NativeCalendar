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
        day.cellIndex = indexPath.row

        switch cellType {
        case .CalendarNewCellType:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarNewCell", for: indexPath) as? CalendarNewCell else {fatalError("cell type error")}
            return setCell(cell: cell, day: day)

        case .CalendarDayCellType:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarDayCell", for: indexPath) as? CalendarDayCell else {fatalError("cell type error")}
            return setCell(cell: cell, day: day)
            
        case .none:
            fatalError("cell type error")
        }
    }
    
    func setCell(cell: UICollectionViewCell, day: Day<Codable>) -> UICollectionViewCell{
        guard let cell = cell as? CalendarDayCell else { return cell }
        cell.setColors(defaultLabelColor: defaultLabelColor,
                       selectedLabelColor: selectedLabelColor,
                       offDaysColor: offDaysColor,
                       selectedBGColor: selectedBGColor)
        cell.setupView()
        cell.setDay(day: day, isMonthView: isMonthView)
        if selectDateBetweenFrom_To(date: day.date) { cell.showLeft_rightBGs() }
        guard let labelText = day.fromToLabel else { return cell }
        cell.setFromTo(text: labelText)
        return cell

//        switch cellType {
//        case .CalendarNewCellType:
//            guard let cell = cell as? CalendarNewCell else { return cell }
//            cell.setColors(defaultLabelColor: defaultLabelColor,
//                           selectedLabelColor: selectedLabelColor,
//                           offDaysColor: offDaysColor,
//                           selectedBGColor: selectedBGColor)
//            cell.setupView()
//            cell.setDay(day: day, isMonthView: isMonthView)
//            if selectDateBetweenFrom_To(date: day.date) { cell.showLeft_rightBGs() }
//            guard let labelText = day.fromToLabel else { return cell }
//            cell.setFromTo(text: labelText)
//            return cell
//
//        case .CalendarDayCellType:
//            guard let cell = cell as? CalendarDayCell else { return cell }
//            cell.setColors(defaultLabelColor: defaultLabelColor,
//                           selectedLabelColor: selectedLabelColor,
//                           offDaysColor: offDaysColor,
//                           selectedBGColor: selectedBGColor)
//            cell.setupView()
//            cell.setDay(day: day, isMonthView: isMonthView)
//            if selectDateBetweenFrom_To(date: day.date) { cell.showLeft_rightBGs() }
//            guard let labelText = day.fromToLabel else { return cell }
//            cell.setFromTo(text: labelText)
//            return cell
//
//        case .none:
//            fatalError("cell type error")
//        }
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
                userSelectedDate.removeAll(where: {$0.dateUTC == days[index].date.timeIntervalSince1970})
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
        userSelectedDate = [UserSelection(dateUTC: days[index].date.timeIntervalSince1970, events: days[index].events)]

    }
    
    private func applyMultiSelection(for index: Int) {
        days[index].isSelected = true
        userSelectedDate.append(UserSelection(dateUTC: days[index].date.timeIntervalSince1970, events: days[index].events))
    }

    private func applyFromToSelection(for index: Int) {
        if userSelectedDate.count < 2 {
            days[index].isSelected = true
            userSelectedDate.append(UserSelection(dateUTC: days[index].date.timeIntervalSince1970, events: days[index].events))
            
            if userSelectedDate.count == 2 {
                days = generateDaysInMonth(for: baseDate)
                setFromToLabel(days: &days)
            }
        }
    }

    private func deselectFromToType(for index: Int) {
        if userSelectedDate.contains(where: {$0.dateUTC == days[index].utc}) {
            userSelectedDate.removeAll(where: {$0.dateUTC == days[index].date.timeIntervalSince1970})
            days = setNotSelected(days: days)
            if !userSelectedDate.isEmpty {
                for dayIndex in 0..<days.count where days[dayIndex].utc == userSelectedDate[0].dateUTC {
                    days[dayIndex].isSelected = true
                }
            }
        }
    }
    
    func setFromToLabel(days: inout [Day<Codable>]) {
        if userSelectedDate.count != 2 || selectionType != .from_to { return }
        for dayIndex in 0..<days.count where days[dayIndex].utc == userSelectedDate[0].dateUTC {
            days[dayIndex].fromToLabel = From_to.from.rawValue
        }
        
        for dayIndex in 0..<days.count where days[dayIndex].utc == userSelectedDate[1].dateUTC {
            days[dayIndex].fromToLabel = From_to.to.rawValue
        }
    }    
}

enum From_to: String {
    case from = "From"
    case to = "To"
}
