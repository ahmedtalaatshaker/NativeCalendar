//
//  CalendarView.swift
//  NativeCalendar
//
//  Created by Ahmed Talaat on 02/02/2023.
//

import UIKit

public class CalendarView: UIView, UICollectionViewDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet var calendarCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var daysLabel: [UILabel]!
    @IBOutlet weak var calendarButton: UIButton!
    
    internal var selectedDate = Date()
    internal var selectedDateCell: CalendarDayCell!
    internal lazy var days = generateDaysInMonth(for: baseDate)
    lazy var daysToBeShown: [Day]! = days
    
    var weekIndex = WeekIndex.first
    var userSelectedDate = Date()
    
    // ---------------------- TODO: pass from outside -------------------
    var calendar: Calendar!
    var offDates: [Date]!
    var datesWithEvents: [Date]!
    var endDate: Date!
    var startDate: Date!
    var firstWeekDay: dayWeek!
    
    public func setData(calendar: Calendar,
         offDates: [Date],
         datesWithEvents: [Date],
         endDate: Date,
         startDate: Date,
         firstWeekDay: dayWeek) {
        self.calendar = calendar
        self.offDates = offDates
        self.datesWithEvents = datesWithEvents
        self.endDate = endDate
        self.startDate = startDate
        self.firstWeekDay = firstWeekDay
        
        if startDate > baseDate {
            baseDate = startDate
        }
        
        daysLabel.forEach { dayLabel in
            dayLabel.text = firstWeekDay.weekDays[dayLabel.tag]
        }
    }
    
    // TODO: selected date to retreive
    public var getSelectedDate: ((Date) -> Void)!

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
        let PathCalendar = UIImage(named: "PathCalendar", in: BMCoreManager.getFrameworkBundle(viewType: CalendarView.self), compatibleWith: nil)
        calendarButton.imageView?.image = PathCalendar
    }
    
    @IBAction func moveMonth(_ sender: UIButton) {
        moveToMonth(month: sender.tag == 1 ? .next : .previous)
    }
    
    private func setupCalendarCollectionView(){
        calendarCollectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: "CalendarDayCell")
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
            
            UIView.animate(withDuration: 0.2, animations: {
                self.calendarHeightConstraint.constant = self.isMonthView ? CalendarHeight.monthMode.rawValue : CalendarHeight.weekMode.rawValue
                self.layoutIfNeeded()
                self.setNeedsLayout()

            }) { completed in
                self.reloadCollectionView()
            }
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
