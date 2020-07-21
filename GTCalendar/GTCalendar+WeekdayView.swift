//
//  GTCalendar+WeekdayView.swift
//  pods_GTCalendar
//
//  Created by Sera Naoto on 2020/03/16.
//  Copyright © 2020 SHIJISHA. All rights reserved.
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
        for view in _stackView.arrangedSubviews {
            _stackView.removeArrangedSubview(view)
        }

        self.addSubview(_stackView)

        _stackView.translatesAutoresizingMaskIntoConstraints = false
        
        _stackView.axis = .horizontal
        _stackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            _stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.bottomAnchor.constraint(equalTo: _stackView.bottomAnchor),
            _stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: _stackView.trailingAnchor),
        ])
         
        for i in 0..<7 {
             let view = UIView()
            let label = UILabel()
            _stackView.addArrangedSubview(view)
            view.addSubview(label)
            view.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
            
            _labels[i]?.textColor = gtCalendar.config.weekdayTextColor
            _labels[i]?.text = gtCalendar.config.weekdayText[i]
            _labels[i]?.font = gtCalendar.config.weekdayFont
            
            if i == 0 {
                _labels[i]?.textColor = gtCalendar.config.weekdaySundayTextColor
            } else if i == 6 {
                _labels[i]?.textColor = gtCalendar.config.weekdaySaturdayTextColor
            }
            
            var text = base[i]

            if gtCalendar.config.weekdayText.count > i {
                text = gtCalendar.config.weekdayText[i]
            }
            _labels[i]?.text = text
        }
    }
}
