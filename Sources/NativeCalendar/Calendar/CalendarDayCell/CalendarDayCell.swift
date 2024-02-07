//
//  collectionViewCell.swift
//  NativeCalendar
//
//  Created by Ahmed Talaat on 06/02/2023.
//

import UIKit

class CalendarDayCell: UICollectionViewCell, ReusableView {
    @IBOutlet weak var selectionBackgroundView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var fromToLabel: UILabel!
    @IBOutlet weak var eventIndicator: UIView!
    @IBOutlet weak var leftBG: UIView!
    @IBOutlet weak var rightBG: UIView!

    var day: Day?
    
    var defaultLabelColor: UIColor!
    var selectedLabelColor: UIColor!
    var offDaysColor: UIColor!
    var selectedBGColor: [CGColor]!
    
    private lazy var accessibilityDateFormatter: DateFormatter = {
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

    func setDay(day: Day?, isMonthView: Bool){
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
        selectionBackgroundView.roundedBorders(radius: selectionBackgroundView.frame.width / 2)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.textAlignment = .center
        dayLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        dayLabel.textColor = defaultLabelColor
        eventIndicator.layer.cornerRadius = eventIndicator.frame.width / 2
        leftBG.isHidden = true
        rightBG.isHidden = true
    }
    
    func setColors(defaultLabelColor: UIColor,
                   selectedLabelColor: UIColor,
                   offDaysColor: UIColor,
                   selectedBGColor: [CGColor]) {
        self.defaultLabelColor = defaultLabelColor
        self.selectedLabelColor = selectedLabelColor
        self.offDaysColor = offDaysColor
        self.selectedBGColor = selectedBGColor
        Helpers.shared.setGradientBackground(forView: selectionBackgroundView, colors: selectedBGColor)
        Helpers.shared.setGradientBackground(forView: leftBG, colors: selectedBGColor)
        Helpers.shared.setGradientBackground(forView: rightBG, colors: selectedBGColor)
        resetView()
    }
    
    func setFromTo(text: String) {
        let cornerRadius = selectionBackgroundView.frame.width / 2
        fromToLabel.isHidden = false
        fromToLabel.text = text
        if text == From_to.to.rawValue {
            leftBG.isHidden = false
            selectionBackgroundView.roundedCorner(cornerRadii: cornerRadius, corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner])
        } else {
            rightBG.isHidden = false
            selectionBackgroundView.roundedCorner(cornerRadii: cornerRadius, corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        }

    }
    
    func showLeft_rightBGs() {
        let cornerRadius = selectionBackgroundView.frame.width / 2

        leftBG.isHidden = false
        rightBG.isHidden = false
        
        selectionBackgroundView.roundedCorner(cornerRadii: 0, corners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner])
//        self.applyDropShadow(radius: cornerRadius)

    }

    private func resetView() {
        let cornerRadius = selectionBackgroundView.frame.width / 2

        leftBG.isHidden = true
        rightBG.isHidden = true
        selectionBackgroundView.roundedCorner(cornerRadii: cornerRadius, corners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner])
//        self.applyDropShadow(radius: cornerRadius)

    }
}

// MARK: - Appearance
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
