//
//  GTCalendar.swift
//  pods_GTCalendar
//
//  Created by Sera Naoto on 2020/02/19.
//  Copyright © 2020 SHIJISHA. All rights reserved.
//

import UIKit

public protocol GTCalendarDataSource {
    func Calendar(_ calendar:GTCalendar, willDisplayCell cell: inout GTCalendar_CalendarViewCell, date:Date)
    func Calendar(_ calendar:GTCalendar, headerTitle date:Date) -> String?
    func Calendar(_ calendar:GTCalendar, isHoliday date:Date) -> String?
}
public extension GTCalendarDataSource {
    func Calendar(_ calendar:GTCalendar, willDisplayCell cell: inout GTCalendar_CalendarViewCell, date:Date) {}
    func Calendar(_ calendar:GTCalendar, headerTitle date:Date) -> String? { return nil }
    func Calendar(_ calendar:GTCalendar, isHoliday date:Date) -> String? { return nil }
}

public protocol GTCalendarDelegate {
    func Calendar(_ calendar:GTCalendar, didSelect date:Date, cell:GTCalendar_CalendarViewCell)
}
public extension GTCalendarDelegate {
    func Calendar(_ calendar:GTCalendar, didSelect date:Date, cell:GTCalendar_CalendarViewCell) {}
}

@IBDesignable
public class GTCalendar: UIView {
    
    public enum SelectionType {
        case Single
        case Multi
        case Period
    }

    public enum PeriodType {
        case Start
        case End
    }

    open var config:GTCalendarConfig = GTCalendarConfig() {
        didSet {
            reloadPages()
            weekdayView.reloadData()
        }
    }
    
    /**
     How to select day(or days
     
     Single:; one day only
     Period: start date and end date.
     Multi: Multipe dates.
     */
    open var selectionType:SelectionType = .Single
    
    /**
     Control selector for the period day
     
     If set true for the periodSelectionAuto, then automatic change this parameter  "end" after a day selected.
     */
    open var periodSelectionTarget:PeriodType = .Start
    
    /**
     Start date available (selectable) in the calendar
     */
    open var minDate:Date? = nil {
        didSet {
            minDate = minDate?.firstDayOfMonth()
        }
    }
    /**
     End date available (selectable) in the calendar
     */
    open var maxDate:Date? = nil {
        didSet {
            maxDate = maxDate?.firstDayOfMonth()
        }
    }

    /**
     Start priod date, The property to set or get when "selectionType" was "Priod"
     */
    open var startDate:Date? = nil {
        didSet {
            reloadPages()
        }
    }
    
    /**
     Start priod date, The property to set or get when "selectionType" was "Priod"
     */
    open var endDate:Date? = nil {
        didSet {
            reloadPages()
        }
    }
    
    /**
     Selected days, The property to set or get when "selectionType" was "Multi"
     */
    open var selectedDays:[Date] = [] {
        didSet {
            if selectionType == .Single && selectedDays.count > 1 {
                selectedDays = [selectedDays.last!]
            }
            reloadPages()
        }
    }

    private var _baseStackView:UIStackView = UIStackView()
    private var _stackView:UIStackView = UIStackView()
    private var weekdayView:GTCalendar_WeekdayView = GTCalendar_WeekdayView()
    private var pageControlView:GTCalendar_PageControlView = GTCalendar_PageControlView()
    private var _containerView:UIView = UIView()
    private var _headerFrameView1:UIView = UIView()
    private var _containerFrameView:UIView = UIView()
    private var _stackViewHeightConstraint:NSLayoutConstraint!
    
    open var delegate:GTCalendarDelegate? = nil
    open var dataSource:GTCalendarDataSource? = nil {
        didSet {
            for page in (pageViewController.viewControllers as? [GTCalendar_PageViewController] ?? []) {
                page.calendarView.reloadData()
            }
        }
    }
    
    let pageViewController:UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        weekdayView.gtCalendar = self
        pageControlView.gtCalendar = self
        initView()
    }
 
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        weekdayView.gtCalendar = self
        pageControlView.gtCalendar = self
        pageViewController.delegate = self
        pageViewController.dataSource = self
        initView()
    }
    
    private func initView() {
        self.backgroundColor = .white

        self.addSubview(_stackView)
        self.addSubview(_baseStackView)
        _headerFrameView1.addSubview(weekdayView)
        _stackView.addArrangedSubview(_headerFrameView1)
        _stackView.addArrangedSubview(_containerFrameView)
        let vc = getMonthlyView(Date().firstDayOfMonth())
        pageViewController.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        _baseStackView.addArrangedSubview(pageViewController.view)
        self.addSubview(pageControlView)

        _baseStackView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        weekdayView.translatesAutoresizingMaskIntoConstraints = false
        pageControlView.translatesAutoresizingMaskIntoConstraints = false
        _headerFrameView1.translatesAutoresizingMaskIntoConstraints = false
        _containerFrameView.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        _headerFrameView1.backgroundColor = .clear
        _stackView.axis = .vertical
        _containerView.backgroundColor = .clear
        _baseStackView.axis = .vertical
        _headerFrameView1.backgroundColor = .clear
        _stackView.isUserInteractionEnabled = false


        NSLayoutConstraint.activate([
            _baseStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.bottomAnchor.constraint(equalTo: _baseStackView.bottomAnchor),
            _baseStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: _baseStackView.trailingAnchor),
            
            _stackView.topAnchor.constraint(equalTo: self.topAnchor),
            _stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: _stackView.trailingAnchor),
            
            _headerFrameView1.heightAnchor.constraint(equalToConstant: 90),
            
            weekdayView.heightAnchor.constraint(equalToConstant: 30),
            _headerFrameView1.bottomAnchor.constraint(equalTo: weekdayView.bottomAnchor),
            weekdayView.leadingAnchor.constraint(equalTo: _headerFrameView1.leadingAnchor),
            _headerFrameView1.trailingAnchor.constraint(equalTo: weekdayView.trailingAnchor),
            
            pageControlView.heightAnchor.constraint(equalToConstant: 60),
            pageControlView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            pageControlView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: pageControlView.trailingAnchor),
            
        ])

        
        self.bringSubviewToFront(_stackView)
                
        reloadPages()
    }
    
    
    /// Reload all calendar page
    open func reloadPages() {
        weekdayView.reloadData()
        
        for var page in (pageViewController.viewControllers as? [GTCalendar_PageViewController] ?? []) {
            updateMonltyView(viewController: &page)
            page.calendarView.reloadData()
        }
    }
    
    ///　Moves the calendar to the specified day.
    ///
    /// If Select is set to truen, that date will be selected. (Selection Type is Single only)
    ///
    /// - Parameters:
    ///   - date:Date at moved
    ///   - select Selected day
    ///   - animated:
    open func moveTo(_ date:Date, select:Bool = false, animated:Bool = true) {
        guard let vc = pageViewController.viewControllers?.last as? GTCalendar_PageViewController else { return }
        let dt = date.firstDayOfMonth()
        let newVc = getMonthlyView(dt)
        if selectionType == .Single && select {
            selectedDays = [date.dayStart()]
        }
        
        if vc.view.tag > newVc.view.tag {
            pageViewController.setViewControllers([newVc], direction: .reverse, animated: animated, completion: nil)
        } else {
            pageViewController.setViewControllers([newVc], direction: .forward, animated: animated, completion: nil)
        }
        newVc.calendarView.reloadData()
    }
    
    /// Moves the calendar by the specified month interval from the current calendar page
    /// - Parameters:
    ///   - intervalMonth: Then move previos month if negative value.
    ///   - animated:
    open func moveTo(_ intervalMonth:Int, animated:Bool = true) {
        guard let vc = pageViewController.viewControllers?.last as? GTCalendar_PageViewController else { return }
        let dt = vc.pageDate.firstDayOfMonth()
        let newVc = getMonthlyView(dt.add(.month, intervalMonth)!)
        if vc.view.tag > newVc.view.tag {
            pageViewController.setViewControllers([newVc], direction: .reverse, animated: animated, completion: nil)
        } else {
            pageViewController.setViewControllers([newVc], direction: .forward, animated: animated, completion: nil)
        }
    }
    
    open func isHoliday(date:Date) -> String? {
        var holiday:String? = nil
        holiday = dataSource?.Calendar(self, isHoliday: date)
        return holiday
    }
    
    private func getMonthlyView(_ date:Date) -> GTCalendar_PageViewController {
        var vc = GTCalendar_PageViewController()
        vc.pageDate = date.firstDayOfMonth()
        vc.gtCalendar = self
        vc.view.tag = Int(date.string("yyyyMM"))!
        
        updateMonltyView(viewController: &vc)
        
        return vc
    }
    
    private func updateMonltyView(viewController:inout GTCalendar_PageViewController) {
        if let headerTitle = dataSource?.Calendar(self, headerTitle: viewController.pageDate.firstDayOfMonth()) {
            viewController.headerLabel.text = headerTitle
        } else {
            viewController.headerLabel.text = viewController.pageDate.firstDayOfMonth().string(config.monthlyHeaderTitleDateFormat)
        }
        viewController.headerLabel.font = config.monthlyHeaderTitleFont
        viewController.headerLabel.textColor = config.monthlyHeaderTitleTextColor
    }
    
    override public func draw(_ rect: CGRect) {
//        initView()
    }
}

extension GTCalendar : UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
    }
}

extension GTCalendar : UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = getMonthlyView((viewController as! GTCalendar_PageViewController).pageDate.add(.month, -1)!)
        return vc
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = getMonthlyView((viewController as! GTCalendar_PageViewController).pageDate.add(.month, 1)!)
        return vc
    }
    
    
}
