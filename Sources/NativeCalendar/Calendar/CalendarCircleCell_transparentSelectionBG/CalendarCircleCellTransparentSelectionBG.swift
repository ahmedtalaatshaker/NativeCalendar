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
        
//        guard let color1 = selectedBGColor.first?.components, let color2 = selectedBGColor[1].components else { return }
//        let newColor = CGColor(red: color1[0], green: color2[1], blue: color1[2], alpha: 0.3)
        leftBG.backgroundColor = colorWithGradient(frame: self.frame, colors: selectedBGColor).withAlphaComponent(0.3) //UIColor(cgColor: color).withAlphaComponent(0.5)
        rightBG.backgroundColor = colorWithGradient(frame: self.frame, colors: selectedBGColor).withAlphaComponent(0.3) //UIColor(cgColor: color).withAlphaComponent(0.5)

//        guard let color = selectedBGColor.first else { return }
//        leftBG.backgroundColor = UIColor(cgColor: color).withAlphaComponent(0.5)
//        rightBG.backgroundColor = UIColor(cgColor: color).withAlphaComponent(0.5)
    }

    func colorWithGradient(frame: CGRect, colors: [CGColor]) -> UIColor {
        // create the background layer that will hold the gradient
        let backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.frame = frame
        // we create an array of CG colors from out UIColor array
//        let cgColors = colors.map({$0})
        backgroundGradientLayer.colors = colors
        UIGraphicsBeginImageContext(backgroundGradientLayer.bounds.size)
        backgroundGradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: backgroundColorImage!)
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
