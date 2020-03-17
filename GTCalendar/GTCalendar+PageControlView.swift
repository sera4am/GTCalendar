//
//  GTCalendar+PageControlView.swift
//  pods_GTCalendar
//
//  Created by 風間剛男 on 2020/03/16.
//  Copyright © 2020 風間剛男. All rights reserved.
//

import UIKit

@IBDesignable
public class GTCalendar_PageControlView: UIView {

    private let stackView:UIStackView = UIStackView()
    private let nextView:UIView = UIView()
    private let prevView:UIView = UIView()
    private let currentView:UIView = UIView()
    private let yearMonthPickerView:UIView = UIView()
    private let yearMonthPickerButton:UIButton = UIButton()
    private let nextLabel:UILabel = UILabel()
    private let prevStackView:UIStackView = UIStackView()
    private let nextStackView:UIStackView = UIStackView()
    private let currentStackView:UIStackView = UIStackView()
    private let prevLabel:UILabel = UILabel()
    private let currentLabel:UILabel = UILabel()
    private let nextImage:UIImageView = UIImageView()
    private let prevImage:UIImageView = UIImageView()
    private let currentImage:UIImageView = UIImageView()
    private let nextButton:UIButton = UIButton(type: .system)
    private let prevButton:UIButton = UIButton(type: .system)
    private let currentButton:UIButton = UIButton(type: .system)
    private var nextWidthConstraint:NSLayoutConstraint!
    private var prevWidthConstraint:NSLayoutConstraint!
    private var currentWidthConstraint:NSLayoutConstraint!
    
    private var gradientStackView:UIStackView = UIStackView()
    private var gradientLeftView:UIView = UIView()
    private var gradientMiddleView:UIView = UIView()
    private var gradientRightView:UIView = UIView()
    
    private let imageSize:CGFloat = 24
    
    var gtCalendar:GTCalendar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    public override func draw(_ rect: CGRect) {
        initView()
    }

    func initView() {
        
        gradientStackView.translatesAutoresizingMaskIntoConstraints = false
        gradientLeftView.translatesAutoresizingMaskIntoConstraints = false
        gradientMiddleView.translatesAutoresizingMaskIntoConstraints = false
        gradientRightView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(gradientStackView)
        self.addConstraints([
            NSLayoutConstraint(item: gradientStackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: gradientStackView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: gradientStackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: gradientStackView, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        gradientStackView.axis = .horizontal
        gradientStackView.distribution = .fillEqually
        gradientStackView.addArrangedSubview(gradientLeftView)
        gradientStackView.addArrangedSubview(gradientMiddleView)
        gradientStackView.addArrangedSubview(gradientRightView)
        
        let gradientLeftLayer = CAGradientLayer()
        gradientLeftLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width / 3, height: 60)
        gradientLeftLayer.colors = [
            UIColor.white.cgColor,
            UIColor.white.withAlphaComponent(0.1).cgColor
        ]
        gradientLeftLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLeftLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLeftView.layer.insertSublayer(gradientLeftLayer, at: 0)
        
        let gradientRightLayer = CAGradientLayer()
        gradientRightLayer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width / 3, height: 60)
        gradientRightLayer.colors = [
            UIColor.white.cgColor,
            UIColor.white.withAlphaComponent(0.1).cgColor
        ]
        gradientRightLayer.startPoint = CGPoint(x: 1, y: 0.5)
        gradientRightLayer.endPoint = CGPoint(x: 0, y: 0.5)
        gradientRightView.layer.insertSublayer(gradientRightLayer, at: 0)
        
        self.sendSubviewToBack(gradientStackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        nextView.translatesAutoresizingMaskIntoConstraints = false
        prevView.translatesAutoresizingMaskIntoConstraints = false
        currentView.translatesAutoresizingMaskIntoConstraints = false
        yearMonthPickerView.translatesAutoresizingMaskIntoConstraints = false
        nextLabel.translatesAutoresizingMaskIntoConstraints = false
        prevLabel.translatesAutoresizingMaskIntoConstraints = false
        currentLabel.translatesAutoresizingMaskIntoConstraints = false
        nextImage.translatesAutoresizingMaskIntoConstraints = false
        prevImage.translatesAutoresizingMaskIntoConstraints = false
        currentImage.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        currentButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        self.addConstraints([
            NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: stackView, attribute: .trailing, multiplier: 1, constant: 8)
        ])
        
        self.backgroundColor = .clear
        stackView.axis = .horizontal
//        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.addArrangedSubview(prevView)
        stackView.addArrangedSubview(yearMonthPickerView)
        stackView.addArrangedSubview(currentView)
        stackView.addArrangedSubview(nextView)
        
        prevView.backgroundColor = .clear
        yearMonthPickerView.backgroundColor = .clear
        currentView.backgroundColor = .clear
        nextView.backgroundColor = .clear
        
        prevButton.backgroundColor = .backgroundClearColor
        nextButton.backgroundColor = .backgroundClearColor
        currentButton.backgroundColor = .backgroundClearColor
        
        prevButton.addTarget(self, action: #selector(onMonthMoveButton(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(onMonthMoveButton(_:)), for: .touchUpInside)
        currentButton.addTarget(self, action: #selector(onMonthMoveButton(_:)), for: .touchUpInside)
        
        yearMonthPickerButton.translatesAutoresizingMaskIntoConstraints = false
        yearMonthPickerView.addSubview(yearMonthPickerButton)
        yearMonthPickerView.addConstraints([
            NSLayoutConstraint(item: yearMonthPickerButton, attribute: .top, relatedBy: .equal, toItem: yearMonthPickerView, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: yearMonthPickerView, attribute: .bottom, relatedBy: .equal, toItem: yearMonthPickerButton, attribute: .bottom, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: yearMonthPickerButton, attribute: .leading, relatedBy: .equal, toItem: yearMonthPickerView, attribute: .leading, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: yearMonthPickerView, attribute: .trailing, relatedBy: .equal, toItem: yearMonthPickerButton, attribute: .trailing, multiplier: 1, constant: 8)
        ])
        yearMonthPickerButton.backgroundColor = .backgroundClearColor
        yearMonthPickerButton.addTarget(self, action: #selector(onMonthMoveButton(_:)), for: .touchUpInside)
        reloadData()
    }
    
    func reloadData() {

        prevView.subviews.forEach { v in
            v.constraints.forEach { c in
                v.removeConstraint(c)
            }
            v.removeFromSuperview()
        }
        nextView.subviews.forEach { v in
            v.constraints.forEach { c in
                v.removeConstraint(c)
            }
            v.removeFromSuperview()
        }
        currentView.subviews.forEach { v in
            v.constraints.forEach { c in
                v.removeConstraint(c)
            }
            v.removeFromSuperview()
        }
        
        prevView.addSubview(prevLabel)
        prevView.addSubview(prevImage)
        prevView.addSubview(prevButton)
        nextView.addSubview(nextLabel)
        nextView.addSubview(nextImage)
        nextView.addSubview(nextButton)
        currentView.addSubview(currentLabel)
        currentView.addSubview(currentImage)
        currentView.addSubview(currentButton)
        
        setConstraintMonth(view: prevView, label: prevLabel, button: prevButton, imageView: prevImage, image: gtCalendar.prevMonthButtonImage, text: gtCalendar.prevMonthButtonTitle, titleColor: gtCalendar.monthButtonTitleColor)
        setConstraintMonth(view: nextView, label: nextLabel, button: nextButton, imageView: nextImage, image: gtCalendar.nextMonthButtonImage, text: gtCalendar.nextMonthButtonTitle, titleColor: gtCalendar.monthButtonTitleColor)
        setConstraintMonth(view: currentView, label: currentLabel, button: currentButton, imageView: currentImage, image: gtCalendar.currentMonthButtonImage, text: gtCalendar.currentMonthButtonTitle, titleColor: gtCalendar.monthButtonTitleColor)
        
    }
    
    @objc func onMonthMoveButton(_ sender:UIButton?) {
        
        switch sender {
        case prevButton:
            gtCalendar.moveTo(-1)
            break
        case nextButton:
            gtCalendar.moveTo(1)
            break
        case currentButton:
            gtCalendar.moveTo(Date())
            break
        default:
            break
        }

    }
    
    func setConstraintMonth(view:UIView, label:UILabel, button:UIButton, imageView:UIImageView, image:UIImage?, text:String?, titleColor:UIColor?) {
        label.text = text
        label.textColor = titleColor
        label.font = gtCalendar.monthButtonTitleFont
        view.addSubview(label)
        
        if text != nil {
            let size = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: label.font.lineHeight))
            view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size.width + 16))
        } else {
            view.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: imageSize + 16))
        }
        
        if image != nil {
            view.addSubview(imageView)
            imageView.image = image
            imageView.tintColor = titleColor
            imageView.addConstraints([
                NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: imageSize),
                NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: imageSize)
            ])
            view.addConstraints([
                NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
            ])
            if text != nil {
                view.addConstraints([
                NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 4)
                ])
            }
        } else {
            view.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        }
        
        view.addConstraints([
            NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: button, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: view
                , attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: button, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        
        view.bringSubviewToFront(button)
    }
}
