//
//  GTCalendar+CalendarViewCell.swift
//  pods_GTCalendar
//
//  Created by Sera Naoto on 2020/02/20.
//  Copyright © 2020 SHIJISHA. All rights reserved.
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
        self.addSubview(subLabel)
        self.addSubview(selectCircle)
        self.addSubview(selectPeriodStackView)
        selectPeriodStackView.addArrangedSubview(selectPeriodStart)
        selectPeriodStackView.addArrangedSubview(selectPeriodEnd)
        
        selectCircle.backgroundColor = .lightGray
        let circleLen = frame.size.width < frame.size.height ? (frame.size.width - 8) : (frame.size.height - 8)
        selectCircle.layer.cornerRadius = circleLen / 2
        selectPeriodStackView.axis = .horizontal
        selectPeriodStackView.distribution = .fillEqually
        selectPeriodStart.backgroundColor = .backgroundClearColor
        selectPeriodEnd.backgroundColor = .backgroundClearColor
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -8),
            
            subLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: subLabel.trailingAnchor),
            self.bottomAnchor.constraint(greaterThanOrEqualTo: subLabel.bottomAnchor),
            label.bottomAnchor.constraint(equalTo: subLabel.topAnchor, constant: -8),
            
            selectCircle.widthAnchor.constraint(equalToConstant: circleLen),
            selectCircle.heightAnchor.constraint(equalToConstant: circleLen),
            
            selectCircle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            selectCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -8),
            
            selectPeriodStackView.heightAnchor.constraint(equalToConstant: circleLen),
            
            selectPeriodStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -8),
            selectPeriodStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: selectPeriodStackView.trailingAnchor),
        ])

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
    }
    
    override public func layoutSubviews() {
    }
}
