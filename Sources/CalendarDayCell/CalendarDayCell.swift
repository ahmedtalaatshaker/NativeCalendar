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
    @IBOutlet weak var eventIndicator: UIView!
    var day: Day?
    
    private lazy var accessibilityDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d")
        return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isAccessibilityElement = true
        accessibilityTraits = .button
        setupView()
    }
    
    func setDay(day: Day?, isMonthView: Bool){
        guard let day = day else { return }
        self.day = day
        dayLabel.text = day.number
        accessibilityLabel = accessibilityDateFormatter.string(from: day.date)
        updateSelectionStatus(isMonthView: isMonthView)
        eventIndicator.isHidden = !day.isHaveEvents
    }
    
    private func setupView(){
        selectionBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        selectionBackgroundView.clipsToBounds = true
        selectionBackgroundView.layer.cornerRadius = selectionBackgroundView.frame.width / 2
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.textAlignment = .center
        dayLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        dayLabel.textColor = .label
        
        eventIndicator.layer.cornerRadius = eventIndicator.frame.width / 2
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
        dayLabel.textColor = .white
        eventIndicator.backgroundColor = .white
        selectionBackgroundView.isHidden = false
    }
    
    // 4
    func applyDefaultStyle(isWithinDisplayedMonth: Bool) {
        accessibilityTraits.remove(.selected)
        accessibilityHint = "Tap to select"
        dayLabel.textColor = isWithinDisplayedMonth ? .label : .secondaryLabel
        selectionBackgroundView.isHidden = true
        eventIndicator.backgroundColor = UIColor(red: 0.749, green: 0.208, blue: 0.278, alpha: 1)
    }
}
