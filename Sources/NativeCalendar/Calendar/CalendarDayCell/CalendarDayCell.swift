//
//  collectionViewCell.swift
//  NativeCalendar
//
//  Created by Ahmed Talaat on 06/02/2023.
//

import UIKit
@available(iOS 13.0, *)
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
                   selectedBGColor: [CGColor]) {
        self.defaultLabelColor = defaultLabelColor
        self.selectedLabelColor = selectedLabelColor
        self.offDaysColor = offDaysColor
        self.selectedBGColor = selectedBGColor
        selectionBackgroundView.setGradientBackground(colors: selectedBGColor)
        if leftBG != nil {
            leftBG.setGradientBackground(colors: setColorWithAlpha())
            rightBG.setGradientBackground(colors: setColorWithAlpha())
        } else {
            eventIndicator.setGradientBackground(colors: [selectedBGColor.first ?? UIColor.black.cgColor, UIColor.cyan.cgColor])
            selectionBackgroundView.layer.borderColor = UIColor.black.cgColor
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
    
    private func setColorWithAlpha() -> [CGColor] {
        return selectedBGColor.map { color in
            color.copy(alpha: 0.2) ?? .init(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    func showLeft_rightBGs() {
        var colors: [CGColor] = setColorWithAlpha()
        selectionBackgroundView.setGradientBackground(colors: colors)
        
        selectionBackgroundView.roundedCorner(cornerRadii: 0, corners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner])
        if leftBG != nil {
            leftBG.isHidden = false
            rightBG.isHidden = false
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
@available(iOS 13.0, *)
extension CalendarDayCell {
    // 1
    func updateSelectionStatus(isMonthView: Bool) {
        guard let day = day else { return }
        
        if day.isSelected {
            applySelectedStyle()
        } else {
            applyDefaultStyle(isWithinDisplayedMonth: (day.isWithinDisplayedMonth || !isMonthView) && !day.isOffDay)
        }
    }
    
    func applySelectedStyle() {
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
    }
}
