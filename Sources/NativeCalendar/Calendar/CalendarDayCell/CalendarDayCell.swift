//
//  collectionViewCell.swift
//  NativeCalendar
//
//  Created by Ahmed Talaat on 06/02/2023.
//

import UIKit
class CalendarDayCell: UICollectionViewCell {
    @IBOutlet weak var selectionBackgroundView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var fromToLabel: UILabel!
    @IBOutlet weak var eventIndicator: UIView!
    @IBOutlet weak var leftBG: UIView!
    @IBOutlet weak var rightBG: UIView!

    var day: Day<Codable>?
    
    var defaultLabelColor: UIColor!
    var selectedLabelColor: UIColor!
    var offDaysColor: UIColor!
    var weekendDayColor: UIColor!
    var selectedBGColor: [CGColor]!
    var selectionViewCornerRadius: CGFloat {
        get {
            selectionBackgroundView.frame.width / 2
        }
    }

    var eventIndicatorCornerRadius: CGFloat {
        get {
            eventIndicator.frame.width / 2
        }
    }

    lazy var accessibilityDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d")
        return dateFormatter
    }()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        isAccessibilityElement = true
        accessibilityTraits = .button
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func setDay(day: Day<Codable>?, isMonthView: Bool){
        guard let day = day else { return }
        self.day = day
        dayLabel.text = day.number
        accessibilityLabel = accessibilityDateFormatter.string(from: day.date)
        updateSelectionStatus(isMonthView: isMonthView)
        eventIndicator.isHidden = !day.isHaveEvents
    }
    
    func setupView(){
        fromToLabel.isHidden = true
        selectionBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        selectionBackgroundView.clipsToBounds = true
        selectionBackgroundView.roundedBorders(radius: selectionViewCornerRadius)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.textAlignment = .center
        dayLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        dayLabel.textColor = defaultLabelColor
        eventIndicator.layer.cornerRadius = eventIndicatorCornerRadius
        if leftBG != nil {
            leftBG.isHidden = true
            rightBG.isHidden = true
        }
    }
    
    func setColors(defaultLabelColor: UIColor,
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
        if leftBG != nil {
            leftBG.setGradientBackground(colors: selectedBGColor)
            rightBG.setGradientBackground(colors: selectedBGColor)
        } else {
            eventIndicator.setGradientBackground(colors: [selectedBGColor.first ?? UIColor.black.cgColor, UIColor.cyan.cgColor])
            selectionBackgroundView.layer.borderColor = UIColor.black.cgColor
            self.applyDropShadow(radius: 4)
        }

        resetView()
    }
    
    func setFromTo(text: String) {
        fromToLabel.isHidden = false
        fromToLabel.text = text
        if text == From_to.to.rawValue {
            selectionBackgroundView.roundedCorner(cornerRadii: selectionViewCornerRadius, corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner])
        } else {
            selectionBackgroundView.roundedCorner(cornerRadii: selectionViewCornerRadius, corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        }
        leftBG != nil ? showHideLeft_rightMargin(text: text) : nil
    }
    
    func showHideLeft_rightMargin(text: String) {
        if text == From_to.to.rawValue {
            leftBG.isHidden = false
        } else {
            rightBG.isHidden = false
        }
    }
    
    func showLeft_rightBGs(isHidden: Bool) {
        selectionBackgroundView.roundedCorner(cornerRadii: 0, corners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner])
        if leftBG != nil {
            leftBG.isHidden = isHidden
            rightBG.isHidden = isHidden
        }
    }

    func resetView() {
        selectionBackgroundView.roundedCorner(cornerRadii: selectionViewCornerRadius, corners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner])
        if leftBG != nil {
            leftBG.isHidden = true
            rightBG.isHidden = true
        }
    }
}

// MARK: - Appearance
extension CalendarDayCell {
    // 1
    func updateSelectionStatus(isMonthView: Bool) {
        guard let day = day else { return }
        
        if day.isSelected || day.isDateBetween{
            applySelectedStyle()
        } else {
            if day.isWeekend {
                applyDefaultStyleForWeekend(isOffDay: day.isOffDay)
            } else {
                applyDefaultStyle(isWithinDisplayedMonth: (day.isWithinDisplayedMonth || !isMonthView) && !day.isOffDay)
            }
        }
    }
    
    func applyDefaultStyleForWeekend(isOffDay: Bool) {
        accessibilityTraits.remove(.selected)
        accessibilityHint = "Tap to select"
        dayLabel.textColor = isOffDay ? offDaysColor : weekendDayColor
        selectionBackgroundView.isHidden = true
        eventIndicator.backgroundColor = UIColor(red: 0.749, green: 0.208, blue: 0.278, alpha: 1)
        showLeft_rightBGs(isHidden: true)
    }
    
    @objc func applySelectedStyle() {
        accessibilityTraits.insert(.selected)
        accessibilityHint = nil
        dayLabel.textColor = selectedLabelColor
        eventIndicator.backgroundColor = selectedLabelColor
        selectionBackgroundView.isHidden = false
    }
    
    // 4
    func applyDefaultStyle(isWithinDisplayedMonth: Bool) {
        accessibilityTraits.remove(.selected)
        accessibilityHint = "Tap to select"
        dayLabel.textColor = isWithinDisplayedMonth ? defaultLabelColor : offDaysColor
        selectionBackgroundView.isHidden = true
        eventIndicator.backgroundColor = UIColor(red: 0.749, green: 0.208, blue: 0.278, alpha: 1)
        showLeft_rightBGs(isHidden: true)
    }
}
