//
//  GTCalendar+PageViewController.swift
//  pods_GTCalendar
//
//  Created by Sera Naoto on 2020/02/20.
//  Copyright © 2020 SHIJISHA. All rights reserved.
//

import UIKit

class GTCalendar_PageViewController: UIViewController {

    let _stackView:UIStackView = UIStackView()
    let headerView:UIView = UIView()
    let headerLabel:UILabel = UILabel()
    let nextButton:UIButton = UIButton()
    let prevButton:UIButton = UIButton()
    let currentButton:UIButton = UIButton()
    let _view:UIView = UIView()
    var calendarView:UICollectionView!
    var calendarLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let reuseIdentifier = "Cell"
    var pageDate:Date!
    var gtCalendar:GTCalendar!
    var delegate:GTCalendarDelegate? = nil
    var dataSource:GTCalendarDataSource? = nil
    var calendarFrameView:UIView = UIView()
    var calendarWidthConstraint:NSLayoutConstraint!
    var calendarHeightConstraint:NSLayoutConstraint!
    
    private var cellSize:CGSize? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        calendarLayout.itemSize = CGSize(width: 100, height: 100)
        calendarLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        calendarLayout.minimumInteritemSpacing = 0.0
        calendarLayout.minimumLineSpacing = 0.0
        calendarLayout.scrollDirection = .vertical
        let calenderFrame:CGRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 80)
        calendarView = UICollectionView(frame: calenderFrame, collectionViewLayout: calendarLayout)
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.register(GTCalendar_CalendarViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        calendarView.backgroundColor = .white
        _stackView.axis = .vertical
        
        view.addSubview(_stackView)
        _stackView.addArrangedSubview(headerView)
        headerView.addSubview(headerLabel)
        _stackView.addArrangedSubview(_view)
        _stackView.addArrangedSubview(calendarFrameView)
        calendarFrameView.addSubview(calendarView)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        _view.translatesAutoresizingMaskIntoConstraints = false
        calendarFrameView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            _stackView.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: _stackView.bottomAnchor),
            _stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: _stackView.trailingAnchor),
            
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            _view.heightAnchor.constraint(equalToConstant: 40),
        ])
        
//        calendarView.layoutIfNeeded()
        calendarWidthConstraint = calendarView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width)
        calendarHeightConstraint = calendarView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height)
        updateCellSize()
        
        NSLayoutConstraint.activate([
            calendarWidthConstraint, calendarHeightConstraint,
            calendarView.centerXAnchor.constraint(equalTo: calendarFrameView.centerXAnchor),
            calendarView.centerYAnchor.constraint(equalTo: calendarFrameView.centerYAnchor),
        ])
        
//        calendarView.layoutSubviews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateOrientation(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)


    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateCellSize()
        calendarView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    @objc func onMoveMonthButton(_ sender:UIButton) {
        switch sender {
        case nextButton:
            gtCalendar.moveTo(pageDate.add(.month, 1)!)
            break
        case prevButton:
            gtCalendar.moveTo(pageDate.add(.month, -1)!)
            break
        case currentButton:
            gtCalendar.moveTo(Date().firstDayOfMonth())
            break
        default:
            break
        }
    }
    
    @objc func updateOrientation(_ notification:Notification) {
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
            self.updateCellSize()
            self.calendarView.reloadData()
        }
    }

    func updateCellSize() {
        DispatchQueue.main.async {
            let width = Int(floor(self.calendarFrameView.frame.size.width / 7.0))
            let height = Int(floor(self.calendarFrameView.frame.size.height / 6.0))
            
            self.calendarWidthConstraint.constant = CGFloat(width * 7)
            self.calendarHeightConstraint.constant = CGFloat(height * 6)
            self.cellSize = CGSize(width: width, height: height)
            self.calendarView.reloadData()
        }
    }

    func getCellTextColor(_ date:Date) -> UIColor {
        var color:UIColor = gtCalendar.config.activeTextColor
        if date.yearMonth() == pageDate.yearMonth() {
            if date.dayOfWeek() == 1 && gtCalendar.config.sundayTextColor != nil {
                color = gtCalendar.config.sundayTextColor!
            } else if date.dayOfWeek() == 7 && gtCalendar.config.saturdayTextColor != nil {
                color = gtCalendar.config.saturdayTextColor!
            }
        } else {
            color = gtCalendar.config.nativeTextColor
            if date.dayOfWeek() == 1 && (gtCalendar.config.saturdayTextColor != nil || gtCalendar.config.saturdayNativeTextColor != nil) {
                color = (gtCalendar.config.sundayNativeTextColor ?? gtCalendar.config.sundayTextColor)!
            } else if date.dayOfWeek() == 7 && (gtCalendar.config.sundayTextColor != nil || gtCalendar.config.sundayNativeTextColor != nil) {
                color = (gtCalendar.config.saturdayNativeTextColor ?? gtCalendar.config.saturdayTextColor)!
            }
        }
        return color
    }
    
    func getCellTextFont(_ date:Date) -> UIFont {
        var font = gtCalendar.config.activeFont
        if date.yearMonth() != pageDate.yearMonth() {
            font = gtCalendar.config.nativeFont
        }
        return font
    }
    
    func getCellSubTextFont(_ date:Date) -> UIFont {
        var font = gtCalendar.config.activeSubLabelFont
        if date.yearMonth() != pageDate.yearMonth() {
            font = gtCalendar.config.nativeSubLabelFont
        }
        return font
    }

    func getSelectCircleColor(_ date:Date) -> UIColor? {
        
        var color:UIColor = .activeSelectCircleColor
        if gtCalendar.config.activeSelectCircleColor != nil {
            color = gtCalendar.config.activeSelectCircleColor!
        }
        if date.yearMonth() != pageDate.yearMonth() && gtCalendar.config.nativeSelectCircleColor != nil {
            color = gtCalendar.config.nativeSelectCircleColor!
        }
        
        switch gtCalendar.selectionType {
        case .Single, .Multi:
            if gtCalendar.selectedDays.contains(date) {
                return color
            }
            break
        case .Period:
            if gtCalendar.startDate != nil && gtCalendar.startDate! == date  {
                return color
            }
            if gtCalendar.endDate != nil && gtCalendar.endDate! == date {
                return color
            }
            break
        }
        
        return nil
    }
    
    func getSelectPeriodColor(_ date:Date) -> [GTCalendar.PeriodType:UIColor] {
        var periodColor:[GTCalendar.PeriodType:UIColor] = [:]
        
        periodColor[.Start] = .backgroundClearColor
        periodColor[.End] = .backgroundClearColor

        var color = gtCalendar.config.activeSelectCircleColor
        if date.yearMonth() != pageDate.yearMonth() && gtCalendar.config.nativeSelectCircleColor != nil {
            color = gtCalendar.config.nativeSelectCircleColor
        }
        
        if gtCalendar.selectionType == .Period && (gtCalendar.startDate != nil || gtCalendar.endDate != nil) {
            
            if gtCalendar.startDate != nil && gtCalendar.startDate! <= date {
                periodColor[.End] = color
                if gtCalendar.endDate == nil {
                    periodColor[.Start] = color
                }
            }
            if gtCalendar.endDate != nil && gtCalendar.endDate! >= date {
                periodColor[.Start] = color
                if gtCalendar.startDate == nil {
                    periodColor[.End] = color
                }
            }
            if gtCalendar.endDate != nil && gtCalendar.endDate! <= date {
                periodColor[.End] = .backgroundClearColor
            }
            if gtCalendar.startDate != nil && gtCalendar.startDate! >= date {
                periodColor[.Start] = .backgroundClearColor
            }

        }
        return periodColor
    }
}

extension GTCalendar_PageViewController : UICollectionViewDataSource {
    

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 * 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = calendarView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GTCalendar_CalendarViewCell

        let wom = indexPath.row / 7 + 1
        let dow = indexPath.row % 7 + 1
        
        let date = Date(pageDate, wom, dow).dayStart()
        cell.date = date
        cell.label.textColor = getCellTextColor(date)
        cell.label.font = getCellTextFont(date)
        cell.subLabel.textColor = cell.label.textColor
        cell.subLabel.font = getCellSubTextFont(date)
        
        if let holiday = gtCalendar.isHoliday(date: date) {
            cell.subLabel.text = holiday
            cell.label.textColor = gtCalendar.config.sundayTextColor
            cell.subLabel.textColor = gtCalendar.config.sundayTextColor
        }
        
        cell.label.text = String(date.day())
        cell.selectCircle.backgroundColor = getSelectCircleColor(date)
        cell.backgroundColor = .white
        let periodColor = getSelectPeriodColor(date)
        cell.selectPeriodStart.backgroundColor = periodColor[.Start]
        cell.selectPeriodEnd.backgroundColor = periodColor[.End]
        
        cell.layoutIfNeeded()
        gtCalendar.dataSource?.Calendar(gtCalendar, willDisplayCell: &cell, date: date)

        return cell
    }
}

extension GTCalendar_PageViewController : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! GTCalendar_CalendarViewCell
        if cell.date == nil {
            return
        }
        
        switch gtCalendar.selectionType {
        case .Single:
            if let index = gtCalendar.selectedDays.firstIndex(of: cell.date!) {
                gtCalendar.selectedDays.remove(at: index)
            } else {
                gtCalendar.selectedDays.append(cell.date!)
            }
            break
        case .Multi:
            gtCalendar.selectedDays.append(cell.date!)
            break
        case .Period:
            if gtCalendar.periodSelectionTarget == .Start {
                if gtCalendar.endDate != nil && gtCalendar.endDate! <= cell.date! {
                    gtCalendar.startDate = gtCalendar.endDate
                } else {
                    gtCalendar.startDate = cell.date
                }
                if gtCalendar.config.periodSelectionAuto {
                    gtCalendar.periodSelectionTarget = .End
                }
            } else if gtCalendar.periodSelectionTarget == .End {
                if gtCalendar.startDate != nil && gtCalendar.startDate! >= cell.date! {
                    gtCalendar.endDate = gtCalendar.startDate
                } else {
                    gtCalendar.endDate = cell.date
                }
            }
        }
        
        gtCalendar.delegate?.Calendar(gtCalendar, didSelect: cell.date!, cell: cell)
    }
}

extension GTCalendar_PageViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /*
        let size = CGSize(width: CGFloat(calendarWidthConstraint.constant / 7.0), height: CGFloat(calendarHeightConstraint.constant / 6.0))
 */
        if cellSize == nil {
            return CGSize(width: self.view.frame.size.width / 7, height: (self.view.frame.size.height - 80) / 6)
        }
        return cellSize!
    }
}
