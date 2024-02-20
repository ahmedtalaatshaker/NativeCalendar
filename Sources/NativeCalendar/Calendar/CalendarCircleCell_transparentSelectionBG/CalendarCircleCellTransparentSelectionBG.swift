//
//  CalendarCircleCellTransparentSelectionBG.swift
//  NativeCalendar
//
//  Created by Ahmed Talaat on 20/02/2024.
//

import UIKit

@available(iOS 13.0, *)
class CalendarCircleCellTransparentSelectionBG: CalendarDayCell {
    override func setColors(defaultLabelColor: UIColor,
                   selectedLabelColor: UIColor,
                   offDaysColor: UIColor,
                   weekendDayColor: UIColor,
                   selectedBGColor: [CGColor]) {
        self.defaultLabelColor = defaultLabelColor
        self.selectedLabelColor = selectedLabelColor
        self.offDaysColor = offDaysColor
        self.weekendDayColor = weekendDayColor
        self.selectedBGColor = selectedBGColor
        selectionBackgroundView.setGradientBackground(colors: selectedBGColor)
        resetView()
        
        guard let color = selectedBGColor.first else { return }
        leftBG.backgroundColor = UIColor(cgColor: color).withAlphaComponent(0.3)
        rightBG.backgroundColor = UIColor(cgColor: color).withAlphaComponent(0.7)
    }

    override func setFromTo(text: String) {
        fromToLabel.isHidden = false
        fromToLabel.text = text
        
        leftBG != nil ? showHideLeft_rightMargin(text: text) : nil
    }
    
    override func showLeft_rightBGs(isHidden: Bool) {
        if leftBG != nil {
            leftBG.isHidden = isHidden
            rightBG.isHidden = isHidden
        }
    }
    
    override func applySelectedStyle() {
        guard let day = day else { return }

        accessibilityTraits.insert(.selected)
        accessibilityHint = nil
        dayLabel.textColor = selectedLabelColor
        eventIndicator.backgroundColor = selectedLabelColor
        if day.isSelected {
            selectionBackgroundView.isHidden = false
        } else {
            if day.isDateBetween {
                selectionBackgroundView.isHidden = true
                showLeft_rightBGs(isHidden: false)
            }
        }
    }
}
