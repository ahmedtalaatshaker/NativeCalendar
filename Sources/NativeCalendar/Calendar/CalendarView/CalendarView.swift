//
//  CalendarView.swift
//  NativeCalendar
//
//  Created by Ahmed Talaat on 02/02/2023.
//

import UIKit
extension UICollectionViewCell: ReusableView { }

public enum CalendarCellType: String {
    case CalendarNewCellType
    case CalendarDayCellType
}

@available(iOS 13.0, *)
public class CalendarView: UIView, UICollectionViewDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var calendarCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var daysLabel: [UILabel]!
    
    internal var selectedDate = Date()
    internal lazy var days = generateDaysInMonth(for: baseDate)
    lazy var daysToBeShown: [Day<Codable>]! = days
    
    var weekIndex = WeekIndex.first
    var userSelectedDate = [UserSelection<Codable>]()
    
    internal var isMonthView: Bool = true {
        didSet {
            weekIndex = .first
            self.calendarHeightConstraint.constant = self.isMonthView ? CalendarHeight.monthMode.rawValue : CalendarHeight.weekMode.rawValue
            self.layoutIfNeeded()
            self.setNeedsLayout()
            self.reloadCollectionView()
        }
    }
    
    var baseDate: Date = Date() {
        didSet {
            days = generateDaysInMonth(for: baseDate)
            monthLabel.text = dateFormatterShowMonth.string(from: baseDate)
        }
    }
    
    internal var numberOfWeeksInBaseDate: Int {
        isMonthView ? numOfWeeksInMonth() : 1
    }
    
    internal lazy var dateFormatterShowDays: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
    
    private lazy var dateFormatterShowMonth: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM y")
        return dateFormatter
    }()

    // ---------------------- MARK: pass from outside -------------------
    var calendar: Calendar!
    var offDates: [Date]!
    var datesWithEvents: [CalendarData<Codable>]!
    var endDate: Date!
    var startDate: Date!
    var firstWeekDay: dayWeek!
    var getSelectedDate: (([UserSelection<Codable>]) -> Void)!
    var selectionType: SelectionType = .single
    // Cell Colors
    var defaultLabelColor: UIColor = .label
    var selectedLabelColor: UIColor = .white
    var offDaysColor: UIColor = .secondaryLabel
    var selectedBGColor: [CGColor] = [#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1).cgColor, #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1).cgColor, #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1).cgColor]
    var cellType: CalendarCellType!
    
    public func setData(calendar: Calendar,
                        cellType: CalendarCellType,
                        offDates: [Date],
                        datesWithEvents: [CalendarData<Codable>],
                        endDate: Date,
                        startDate: Date,
                        firstWeekDay: dayWeek,
                        selectionType: SelectionType,
                        getSelectedDate: @escaping (([UserSelection<Codable>]) -> Void)) {
        self.calendar = calendar
        self.offDates = offDates
        self.datesWithEvents = datesWithEvents
        self.endDate = endDate
        self.startDate = startDate
        self.firstWeekDay = firstWeekDay
        self.getSelectedDate = getSelectedDate
        self.selectionType = selectionType
        self.cellType = cellType

        if startDate > baseDate {
            baseDate = startDate
        }
        
        daysLabel.forEach { dayLabel in
            dayLabel.text = firstWeekDay.weekDays[dayLabel.tag]
        }
        setupCalendarCollectionView()
    }
    
    public func setCellStyle(defaultLabelColor: UIColor,
                             selectedLabelColor: UIColor,
                             offDaysColor: UIColor,
                             selectedBGColor: [CGColor]) {
        self.defaultLabelColor = defaultLabelColor
        self.selectedLabelColor = selectedLabelColor
        self.offDaysColor = offDaysColor
        self.selectedBGColor = selectedBGColor
    }
    
    // -----------------------------------
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initUi()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initUi()
    }
    
    func initUi(){
        fromNib(viewType: Self.self, frombunde: Bundle.module)
        monthLabel.text = dateFormatterShowMonth.string(from: baseDate)
        calendarCollectionView.layer.cornerRadius = 10
        containerView.layer.cornerRadius = 10
    }
    
    @IBAction func moveMonth(_ sender: UIButton) {
        moveToMonth(month: sender.tag == 1 ? .next : .previous)
    }
    
    private func setupCalendarCollectionView(){
        calendarCollectionView.registerReusableCell(CalendarDayCell.self)
        calendarCollectionView.registerReusableCell(CalendarCell.self)

        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        calendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func reloadCollectionView(){
        
        if isMonthView {
            daysToBeShown = days
        }else{
            daysToBeShown = Array(days[weekIndex.range])
        }
        UIView.animate(withDuration: 1) {
            self.calendarCollectionView.reloadData()
        }
    }
    
    @IBAction func changeMonth_WeekView(_ sender: UIButton) {
        isMonthView.toggle()
    }
    
    
}
