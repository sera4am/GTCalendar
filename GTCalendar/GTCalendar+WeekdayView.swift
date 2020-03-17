//
//  GTCalendar+WeekdayView.swift
//  pods_GTCalendar
//
//  Created by 風間剛男 on 2020/03/16.
//  Copyright © 2020 風間剛男. All rights reserved.
//

import UIKit

@IBDesignable
class GTCalendar_WeekdayView: UIView {

    private var _stackView:UIStackView = UIStackView()
    private var _weekViews:[Int:UIView] = [:]
    private var _labels:[Int:UILabel] = [:]
    weak var gtCalendar:GTCalendar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }

    
    func initView() {
        
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        _stackView.axis = .horizontal
        _stackView.distribution = .fillEqually
        self.addSubview(_stackView)
        self.addConstraints([
            NSLayoutConstraint(item: _stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: _stackView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: _stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: _stackView, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        
        for view in _stackView.arrangedSubviews {
            _stackView.removeArrangedSubview(view)
        }
        
        for i in 0..<7 {
            print("[WeekdayStack]", i)
            let view = UIView()
            let label = UILabel()
            _stackView.addArrangedSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraints([
                NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
            ])
            view.backgroundColor = .white
            
            _weekViews[i] = view
            _labels[i] = label
        }
        
        reloadData()
    }
    
    override func draw(_ rect: CGRect) {
        initView()
    }
    
    func reloadData() {
        let base = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        
        for i in 0..<7 {
            
            _labels[i]?.textColor = gtCalendar.weekDayTextColor
            _labels[i]?.text = gtCalendar.weekDayText[i]
            _labels[i]?.font = gtCalendar.weekDayFont
            
            if i == 0 {
                _labels[i]?.textColor = gtCalendar.weekDaySundayTextColor
            } else if i == 6 {
                _labels[i]?.textColor = gtCalendar.weekDaySaturdayTextColor
            }
            
            var text = base[i]
            if gtCalendar.weekDayText.count > i {
                text = gtCalendar.weekDayText[i]
            }
            _labels[i]?.text = text
        }
    }
}
