//
//  collectionViewCell.swift
//  NativeCalendar
//
//  Created by Ahmed Talaat on 06/02/2023.
//

import UIKit

@available(iOS 13.0, *)
class CalendarCell: CalendarDayCell {
    override var selectionViewCornerRadius: CGFloat {
        get {
            return 4
        }
    }

    override var eventIndicatorCornerRadius: CGFloat {
        get {
            return 2
        }
    }
}
