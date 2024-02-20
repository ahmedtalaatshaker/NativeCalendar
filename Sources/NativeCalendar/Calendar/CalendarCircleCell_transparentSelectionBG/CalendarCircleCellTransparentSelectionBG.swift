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
        leftBG.backgroundColor = .gray
        rightBG.backgroundColor = .gray

        resetView()
    }

    override func setFromTo(text: String) {
        fromToLabel.isHidden = false
        fromToLabel.text = text
        
        leftBG != nil ? showHideLeft_rightMargin(text: text) : nil
    }
    
    override func showLeft_rightBGs() {
        if leftBG != nil {
            leftBG.isHidden = false
            rightBG.isHidden = false
        }
    }
}
