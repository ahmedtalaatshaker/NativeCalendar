//
//  CalendarView.swift
//  NativeCalendar
//
//  Created by Ahmed Talaat on 02/02/2023.
//

import UIKit

@available(iOS 13.0, *)
public class CalendarView: UIView, UICollectionViewDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var calendarCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var daysLabel: [UILabel]!
    
    internal var selectedDate = Date()
    internal var selectedDateCell: CalendarDayCell!
    internal lazy var days = generateDaysInMonth(for: baseDate)
    lazy var daysToBeShown: [Day]! = days
    
    var weekIndex = WeekIndex.first
    var userSelectedDate = TimeInterval()
    
    // ---------------------- TODO: pass from outside -------------------
    var calendar: Calendar!
    var offDates: [Date]!
    var datesWithEvents: [Date]!
    var endDate: Date!
    var startDate: Date!
    var firstWeekDay: dayWeek!
    var getSelectedDate: ((TimeInterval) -> Void)!
    
    // Cell Colors
    var defaultLabelColor: UIColor = .label
    var selectedLabelColor: UIColor = .white
    var offDaysColor: UIColor = .secondaryLabel
    var selectedBGColor: UIColor = .red
    
    public func setData(calendar: Calendar,
                        offDates: [Date],
                        datesWithEvents: [Date],
                        endDate: Date,
                        startDate: Date,
                        firstWeekDay: dayWeek, 
                        getSelectedDate: @escaping ((TimeInterval) -> Void)) {
        self.calendar = calendar
        self.offDates = offDates
        self.datesWithEvents = datesWithEvents
        self.endDate = endDate
        self.startDate = startDate
        self.firstWeekDay = firstWeekDay
        self.getSelectedDate = getSelectedDate
        
        if startDate > baseDate {
            baseDate = startDate
        }
        
        daysLabel.forEach { dayLabel in
            dayLabel.text = firstWeekDay.weekDays[dayLabel.tag]
        }
    }
    
    public func setCellStyle(defaultLabelColor: UIColor,
                             selectedLabelColor: UIColor,
                             offDaysColor: UIColor,
                             selectedBGColor: UIColor) {
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
        setupCalendarCollectionView()
        monthLabel.text = dateFormatterShowMonth.string(from: baseDate)
        calendarCollectionView.layer.cornerRadius = 10
        containerView.layer.cornerRadius = 10
    }
    
    @IBAction func moveMonth(_ sender: UIButton) {
        moveToMonth(month: sender.tag == 1 ? .next : .previous)
    }
    
    private func setupCalendarCollectionView(){
        calendarCollectionView.registerReusableCell(CalendarDayCell.self)
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
    
}
