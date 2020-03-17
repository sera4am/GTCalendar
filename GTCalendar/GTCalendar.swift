//
//  GTCalendar.swift
//  pods_GTCalendar
//
//  Created by 世来直人 on 2020/02/19.
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

    @IBInspectable open var activeTextColor:UIColor = .black { didSet { reloadPages() } }
    @IBInspectable open var nativeTextColor:UIColor = .gray { didSet { reloadPages() } }
    @IBInspectable open var monthlyHeaderTitleDateFormat:String = "MMM yyyy" { didSet { reloadPages() } }
    open var activeFont:UIFont = UIFont(name: "Arial", size: 14.0)! { didSet { reloadPages() } }
    open var nativeFont:UIFont = UIFont(name: "Arial", size: 12.0)! { didSet { reloadPages() } }
    open var activeSubLabelFont:UIFont = UIFont(name: "Arial", size: 10.0)! { didSet { reloadPages() }}
    open var nativeSubLabelFont:UIFont = UIFont(name: "Arial", size: 8.0)! { didSet { reloadPages() }}
    open var timeZone:TimeZone = TimeZone.current { didSet { reloadPages() } }
    open var weekDayText:[String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"] { didSet { reloadPages() } }
    open var headerTextColor:UIColor = .activeDefaultTextColor { didSet { reloadPages() } }
    open var saturdayTextColor:UIColor? = .activeBlueTextColor { didSet { reloadPages() } }
    open var sundayTextColor:UIColor? = .activeRedTextColor { didSet { reloadPages() } }
    open var saturdayNativeTextColor:UIColor? = .nativeBlueTextClor { didSet { reloadPages() } }
    open var sundayNativeTextColor:UIColor? = .nativeRedTextColor { didSet { reloadPages() } }
    open var activeSelectCircleColor:UIColor? = .activeSelectCircleColor { didSet { reloadPages() } }
    open var nativeSelectCircleColor:UIColor? = .nativeSelectCircleColor { didSet { reloadPages() } }
    open var activeTodayCircleColor:UIColor? = .activeTodayCircleColor { didSet { reloadPages() }}
    open var nativeTodayCircleColor:UIColor? = .nativeTodayCircleColor { didSet { reloadPages() }}
    open var prevMonthButtonTitle:String? = "Prev Mon" { didSet { reloadPages() }}
    open var nextMonthButtonTitle:String? = "Next Mon" { didSet { reloadPages() }}
    open var currentMonthButtonTitle:String? = "Current Mon" { didSet { reloadPages() }}
    open var prevMonthButtonImage:UIImage? = nil
    open var nextMonthButtonImage:UIImage? = nil
    open var currentMonthButtonImage:UIImage? = nil
    open var monthButtonTitleColor:UIColor = .blue { didSet { reloadPages() }}
    open var monthButtonTitleFont:UIFont = UIFont(name: "Arial", size: 10.0)!
    open var monthButtonNativeTitleColor:UIColor = .nativeDefaultTextolor
    open var weekDayFont:UIFont = UIFont(name: "arial", size: 9.0)! { didSet { weekdayView.reloadData() }}
    open var weekDayTextColor:UIColor = .activeDefaultTextColor { didSet { weekdayView.reloadData() }}
    open var weekDaySundayTextColor:UIColor = .activeRedTextColor { didSet { weekdayView.reloadData() }}
    open var weekDaySaturdayTextColor:UIColor = .activeBlueTextColor { didSet { weekdayView.reloadData() }}
    open var selectionType:SelectionType = .Single { didSet { reloadPages() } }
    open var periodSelectionTarget:PeriodType = .Start { didSet { _periodView.changeSelector()}}
    open var periodTitleFont:UIFont = UIFont(name: "Arial", size: 9.0)!
    open var periodTitleTextColor:UIColor = .nativeDefaultTextolor { didSet { _periodView.reloadData() }}
    open var periodSelectedTitleTextColor:UIColor = .activeDefaultTextColor { didSet { _periodView.reloadData() }}
    open var periodDateFormat:String = "yyyy-MM-dd" { didSet { _periodView.reloadData() }}
    open var periodDateFont:UIFont = UIFont(name: "Arial", size: 12.0)!
    open var periodDateTextColor:UIColor = .activeBlueTextColor { didSet { _periodView.reloadData() }}
    open var periodStartTitle:String = "Start Date" { didSet { _periodView.reloadData() }}
    open var periodEndTitle:String = "End Date" { didSet { _periodView.reloadData() }}
    open var periodToText:String = "to" { didSet { _periodView.reloadData() }}
    open var periodToTextColor:UIColor = .activeBlueTextColor { didSet { _periodView.reloadData() }}
    open var periodToFont:UIFont = UIFont(name: "Arial", size: 14.0)!
    open var periodSelectorbarColor:UIColor = .brown { didSet { _periodView.reloadData() }}
    open var periodDateminedText:String = "<Datemined>" { didSet { _periodView.reloadData() }}
    open var periodDateminedTextColor:UIColor = .gray { didSet { _periodView.reloadData() }}
    
    
    open var minDate:Date? = nil {
        didSet {
            minDate = minDate?.firstDayOfMonth()
        }
    }
    open var maxDate:Date? = nil {
        didSet {
            maxDate = maxDate?.firstDayOfMonth()
        }
    }
    
    open var startDate:Date? = nil {
        didSet {
            reloadPages()
        }
    }
    open var endDate:Date? = nil {
        didSet {
            reloadPages()
        }
    }
    
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
    private var _periodView:GTCalendar_PeriodView = GTCalendar_PeriodView()
    private var _periodHeight:CGFloat = 50
    
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
        initView()
    }
 
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        initView()
    }
    
    private func initView() {
        self.backgroundColor = .white
        _baseStackView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        weekdayView.translatesAutoresizingMaskIntoConstraints = false
        pageControlView.translatesAutoresizingMaskIntoConstraints = false
        _headerFrameView1.translatesAutoresizingMaskIntoConstraints = false
        _containerFrameView.translatesAutoresizingMaskIntoConstraints = false
        _periodView.translatesAutoresizingMaskIntoConstraints = false
        _headerFrameView1.backgroundColor = .clear
        
        weekdayView.gtCalendar = self
        pageControlView.gtCalendar = self
        _periodView.gtCalendar = self
        self.addSubview(_stackView)

        NSLayoutConstraint.activate([
            _stackView.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
        self.addSubview(_baseStackView)
        _baseStackView.axis = .vertical
        self.addConstraints([
            NSLayoutConstraint(item: _baseStackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: _baseStackView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: _baseStackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: _baseStackView, attribute: .trailing, multiplier: 1, constant: 0)
        ])

        self.addConstraints([
            NSLayoutConstraint(item: _stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: _stackView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: _stackView, attribute: .bottom, multiplier: 1, constant: _periodHeight)

        ])
        _headerFrameView1.addConstraint(NSLayoutConstraint(item: _headerFrameView1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 90))
        _headerFrameView1.backgroundColor = .clear
        _headerFrameView1.addSubview(weekdayView)
        weekdayView.addConstraint(NSLayoutConstraint(item: weekdayView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30))
        _headerFrameView1.addConstraints([
            NSLayoutConstraint(item: _headerFrameView1, attribute: .bottom, relatedBy: .equal, toItem: weekdayView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: weekdayView, attribute: .leading, relatedBy: .equal, toItem: _headerFrameView1, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: _headerFrameView1, attribute: .trailing, relatedBy: .equal, toItem: weekdayView, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        
        _stackView.axis = .vertical
        _stackView.addArrangedSubview(_headerFrameView1)
        _containerView.backgroundColor = .clear
        _stackView.addArrangedSubview(_containerFrameView)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.delegate = self
        pageViewController.dataSource = self
        let vc = getMonthlyView(Date().firstDayOfMonth())
        pageViewController.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        _baseStackView.addArrangedSubview(pageViewController.view)
        _stackView.isUserInteractionEnabled = false
        self.bringSubviewToFront(_stackView)
        
        self.addSubview(pageControlView)
        pageControlView.addConstraint(NSLayoutConstraint(item: pageControlView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60))
        self.addConstraints([
            NSLayoutConstraint(item: pageControlView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: pageControlView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: pageControlView, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        
        _baseStackView.addArrangedSubview(_periodView)
        _periodView.addConstraint(NSLayoutConstraint(item: _periodView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40))

        _periodView.isHidden = true
        reloadPages()
    }
    
    open func reloadPages() {
        weekdayView.reloadData()
        
        if selectionType == .Period {
            _periodView.isHidden = false
            _periodView.reloadData()
        }
        for var page in (pageViewController.viewControllers as? [GTCalendar_PageViewController] ?? []) {
            updateMonltyView(viewController: &page)
            page.calendarView.reloadData()
        }
    }
    
    open func moveTo(_ date:Date, select:Bool = false) {
        guard let vc = pageViewController.viewControllers?.last as? GTCalendar_PageViewController else { return }
        let dt = date.firstDayOfMonth()
        let newVc = getMonthlyView(dt)
        if vc.view.tag > newVc.view.tag {
            pageViewController.setViewControllers([newVc], direction: .reverse, animated: true, completion: nil)
        } else {
            pageViewController.setViewControllers([newVc], direction: .forward, animated: true, completion: nil)
        }
    }
    
    open func moveTo(_ intervalMonth:Int) {
        guard let vc = pageViewController.viewControllers?.last as? GTCalendar_PageViewController else { return }
        let dt = vc.pageDate.firstDayOfMonth()
        let newVc = getMonthlyView(dt.add(.month, intervalMonth)!)
        if vc.view.tag > newVc.view.tag {
            pageViewController.setViewControllers([newVc], direction: .reverse, animated: true, completion: nil)
        } else {
            pageViewController.setViewControllers([newVc], direction: .forward, animated: true, completion: nil)
        }
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
            viewController.headerLabel.text = viewController.pageDate.firstDayOfMonth().string(monthlyHeaderTitleDateFormat)
        }
        viewController.headerLabel.textColor = headerTextColor
    }
    
    open func isHoliday(date:Date) -> String? {
        var holiday:String? = nil
        holiday = dataSource?.Calendar(self, isHoliday: date)
        return holiday
    }
    
    override public func draw(_ rect: CGRect) {
        self.frame = rect
        initView()
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
