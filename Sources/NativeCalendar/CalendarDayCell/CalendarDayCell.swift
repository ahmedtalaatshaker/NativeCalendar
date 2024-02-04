//
//  collectionViewCell.swift
//  NativeCalendar
//
//  Created by Ahmed Talaat on 06/02/2023.
//

import UIKit

public class CalendarDayCell: UICollectionViewCell, ReusableView {
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
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        isAccessibilityElement = true
        accessibilityTraits = .button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)

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
    
    func setupView(){
        selectionBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        selectionBackgroundView.clipsToBounds = true
        selectionBackgroundView.layer.cornerRadius = selectionBackgroundView.frame.width / 2
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.textAlignment = .center
        dayLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        if #available(iOS 13.0, *) {
            dayLabel.textColor = .label
        } else {
            // Fallback on earlier versions
        }
        
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
        if #available(iOS 13.0, *) {
            dayLabel.textColor = isWithinDisplayedMonth ? .label : .secondaryLabel
        } else {
            // Fallback on earlier versions
        }
        selectionBackgroundView.isHidden = true
        eventIndicator.backgroundColor = UIColor(red: 0.749, green: 0.208, blue: 0.278, alpha: 1)
    }
}



///////////
///
///
///


public class BMCoreManager {

    
    public static func getFrameworkBundle<T>(viewType: T.Type) -> Bundle {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        return Bundle(for: viewType.self as! AnyClass)
#endif
    }

    public static func subscribe() {
//        UIFont.registerCustomFonts()
       // BMGoogleMapManger.shared.initiateMapService(key: "AIzaSyDQf43yGsqk2HFsmDZUMTqvU3OnMnl3e8Y")
    }

}



public protocol ReusableView: AnyObject {
    static var reusableIdentifier: String { get }
    static var nib: UINib? { get }
}

public extension ReusableView where Self: UIView {
    
    static var reusableIdentifier: String { return String(describing: self) }
    static var nib: UINib? {
        if Bundle.init(for: Self.self).path(forResource: String(describing: self), ofType: "nib") != nil {
            return UINib(nibName: String(describing: self), bundle: Bundle.init(for: Self.self))
        }else if (BMCoreManager.getFrameworkBundle(viewType: Self.self).path(forResource: String(describing: self), ofType: "nib")) != nil {
            return UINib(nibName: String(describing: self), bundle: BMCoreManager.getFrameworkBundle(viewType: Self.self))
        }else {
            return nil
        }
    }
}

extension UICollectionView {
    
    public func registerReusableCell<T: UICollectionViewCell>(_ cells: T.Type) where T: ReusableView {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.reusableIdentifier)
        } else {
            register(T.self, forCellWithReuseIdentifier: T.reusableIdentifier)
        }
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        return cell
    }
    
    public func registerReusableSupplementaryView<T: ReusableView>(elementKind: String, _: T.Type) {
        if let nib = T.nib {
            self.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reusableIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reusableIdentifier)
        }
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(elementKind: String, indexPath: IndexPath) -> T where T: ReusableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reusableIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(T.reusableIdentifier)")
        }
        return view
    }
    
    public func dequeueReusableCell<C: UICollectionViewCell>(withCellType type: C.Type = C.self, for indexPath: IndexPath) -> C where C: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.reusableIdentifier, for: indexPath) as? C
        else { fatalError("Couldn't dequeue a UICollectionViewCell with identifier: \(type.reusableIdentifier)") }
        return cell
    }
    
    public func register<C: UICollectionViewCell>(cellType: C.Type) where C: ReusableView {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.reusableIdentifier)
    }
}

