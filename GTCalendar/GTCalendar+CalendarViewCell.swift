//
//  GTCalendar+CalendarViewCell.swift
//  pods_GTCalendar
//
//  Created by 風間剛男 on 2020/02/20.
//  Copyright © 2020 風間剛男. All rights reserved.
//

import UIKit

public class GTCalendar_CalendarViewCell: UICollectionViewCell {
    
    open var date:Date? = nil
    open var label:UILabel = UILabel()
    open var subLabel:UILabel = UILabel()
    internal var selectCircle:UIView = UIView()
    internal var selectPeriodStackView:UIStackView = UIStackView()
    internal var selectPeriodStart:UIView = UIView()
    internal var selectPeriodEnd:UIView = UIView()
//    var todayView:UIView = UIView()
    private var stackView:UIStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        selectCircle.translatesAutoresizingMaskIntoConstraints = false
        selectPeriodStackView.translatesAutoresizingMaskIntoConstraints = false

        subLabel.textAlignment = .center
        subLabel.numberOfLines = 0
        
        self.addSubview(label)
        self.addConstraints([
            NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -8)
        ])
        
        self.addSubview(subLabel)
        self.addConstraints([
            NSLayoutConstraint(item: subLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: subLabel, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: subLabel, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: subLabel, attribute: .top, multiplier: 1, constant: -8)
        ])
        
        self.addSubview(selectCircle)
        selectCircle.backgroundColor = .lightGray
        let circleLen = frame.size.width < frame.size.height ? (frame.size.width - 8) : (frame.size.height - 8)
        selectCircle.layer.cornerRadius = circleLen / 2
        selectCircle.addConstraints([
            NSLayoutConstraint(item: selectCircle, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: circleLen),
            NSLayoutConstraint(item: selectCircle, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: circleLen)
        ])
        self.addConstraints([
            NSLayoutConstraint(item: selectCircle, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: selectCircle, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -8)
        ])

        selectPeriodStackView.axis = .horizontal
        selectPeriodStackView.distribution = .fillEqually
        self.addSubview(selectPeriodStackView)
        selectPeriodStackView.addConstraints([
            NSLayoutConstraint(item: selectPeriodStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: circleLen)
        ])
        self.addConstraints([
            NSLayoutConstraint(item: selectPeriodStackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: selectPeriodStackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: selectPeriodStackView, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        selectPeriodStackView.addArrangedSubview(selectPeriodStart)
        selectPeriodStackView.addArrangedSubview(selectPeriodEnd)
        
        selectPeriodStart.backgroundColor = .backgroundClearColor
        selectPeriodEnd.backgroundColor = .backgroundClearColor

        self.bringSubviewToFront(selectCircle)
        self.bringSubviewToFront(subLabel)
        self.bringSubviewToFront(label)
        
        self.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func prepareForReuse() {
        date = nil
        label.text = nil
        subLabel.text = nil
        selectCircle.backgroundColor = .clear
        selectPeriodStart.backgroundColor = .clear
        selectPeriodEnd.backgroundColor = .clear
//        todayView.backgroundColor = .clear
    }
    
    override public func layoutSubviews() {
    }
}
