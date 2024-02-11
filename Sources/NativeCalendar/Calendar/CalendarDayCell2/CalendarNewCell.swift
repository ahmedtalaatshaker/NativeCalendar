//
//  collectionViewCell.swift
//  NativeCalendar
//
//  Created by Ahmed Talaat on 06/02/2023.
//

import UIKit

class CalendarNewCell: UICollectionViewCell, ReusableView, CalendarCell {
    func showLeft_rightBGs() {
        
    }
    
    @IBOutlet weak var selectionBackgroundـView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var fromToLabel: UILabel!
    @IBOutlet weak var eventIndicator: UIView!

    var day: Day<Codable>?
    
    var defaultLabelColor: UIColor!
    var selectedLabelColor: UIColor!
    var offDaysColor: UIColor!
    var selectedBGColor: [CGColor]!
    let selectionViewCornerRadius: CGFloat = 4

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
        selectionBackgroundـView.translatesAutoresizingMaskIntoConstraints = false
        selectionBackgroundـView.clipsToBounds = true
        selectionBackgroundـView.roundedBorders(radius: selectionViewCornerRadius)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.textAlignment = .center
        dayLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        dayLabel.textColor = defaultLabelColor
        eventIndicator.layer.cornerRadius = 2
    }
    
    func setColors(defaultLabelColor: UIColor,
                   selectedLabelColor: UIColor,
                   offDaysColor: UIColor,
                   selectedBGColor: [CGColor]) {
        self.defaultLabelColor = defaultLabelColor
        self.selectedLabelColor = selectedLabelColor
        self.offDaysColor = offDaysColor
        self.selectedBGColor = selectedBGColor
        selectionBackgroundـView.setGradientBackground(colors: selectedBGColor)
        selectionBackgroundـView.layer.borderColor = UIColor.black.cgColor
        resetView()
    }
    
    func setFromTo(text: String) {
        fromToLabel.isHidden = false
        fromToLabel.text = text
        if text == From_to.to.rawValue {
            selectionBackgroundـView.roundedCorner(cornerRadii: selectionViewCornerRadius, corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner])
        } else {
            selectionBackgroundـView.roundedCorner(cornerRadii: selectionViewCornerRadius, corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        }
    }

    func resetView() {
        selectionBackgroundـView.roundedCorner(cornerRadii: selectionViewCornerRadius, corners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner])
    }
}

// MARK: - Appearance
extension CalendarNewCell {
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
        selectionBackgroundـView.isHidden = false
    }
    
    // 4
    func applyDefaultStyle(isWithinDisplayedMonth: Bool) {
        accessibilityTraits.remove(.selected)
        accessibilityHint = "Tap to select"
        dayLabel.textColor = isWithinDisplayedMonth ? defaultLabelColor : offDaysColor
        selectionBackgroundـView.isHidden = true
        eventIndicator.backgroundColor = UIColor(red: 0.749, green: 0.208, blue: 0.278, alpha: 1)
    }
}
