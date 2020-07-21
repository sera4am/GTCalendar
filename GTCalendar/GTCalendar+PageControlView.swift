//
//  GTCalendar+PageControlView.swift
//  pods_GTCalendar
//
//  Created by Sera Naoto on 2020/03/16.
//  Copyright © 2020 SHIJISHA. All rights reserved.
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
        self.addSubview(gradientStackView)
        self.sendSubviewToBack(gradientStackView)
        gradientStackView.addArrangedSubview(gradientLeftView)
        gradientStackView.addArrangedSubview(gradientMiddleView)
        gradientStackView.addArrangedSubview(gradientRightView)
        self.addSubview(stackView)
        stackView.addArrangedSubview(prevView)
        stackView.addArrangedSubview(yearMonthPickerView)
        stackView.addArrangedSubview(currentView)
        stackView.addArrangedSubview(nextView)
        yearMonthPickerView.addSubview(yearMonthPickerButton)
        
        gradientStackView.translatesAutoresizingMaskIntoConstraints = false
        gradientLeftView.translatesAutoresizingMaskIntoConstraints = false
        gradientMiddleView.translatesAutoresizingMaskIntoConstraints = false
        gradientRightView.translatesAutoresizingMaskIntoConstraints = false
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
        yearMonthPickerButton.translatesAutoresizingMaskIntoConstraints = false

        gradientStackView.axis = .horizontal
        gradientStackView.distribution = .fillEqually

        
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
        
        self.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.spacing = 8
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
        yearMonthPickerButton.backgroundColor = .backgroundClearColor
        yearMonthPickerButton.addTarget(self, action: #selector(onMonthMoveButton(_:)), for: .touchUpInside)

        NSLayoutConstraint.activate([
            gradientStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.bottomAnchor.constraint(equalTo: gradientStackView.bottomAnchor),
            gradientStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: gradientStackView.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 8),
            
            yearMonthPickerButton.topAnchor.constraint(equalTo: yearMonthPickerView.topAnchor, constant: 8),
            yearMonthPickerView.bottomAnchor.constraint(equalTo: yearMonthPickerButton.bottomAnchor, constant: 8),
            yearMonthPickerButton.leadingAnchor.constraint(equalTo: yearMonthPickerView.leadingAnchor, constant: 8),
            yearMonthPickerView.trailingAnchor.constraint(equalTo: yearMonthPickerButton.trailingAnchor, constant: 8),
        ])
        
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
        
        setConstraintMonth(view: prevView, label: prevLabel, button: prevButton, imageView: prevImage, image: gtCalendar.config.prevMonthButtonImage, text: gtCalendar.config.prevMonthButtonTitle, titleColor: gtCalendar.config.monthButtonTitleColor)
        setConstraintMonth(view: nextView, label: nextLabel, button: nextButton, imageView: nextImage, image: gtCalendar.config.nextMonthButtonImage, text: gtCalendar.config.nextMonthButtonTitle, titleColor: gtCalendar.config.monthButtonTitleColor)
        setConstraintMonth(view: currentView, label: currentLabel, button: currentButton, imageView: currentImage, image: gtCalendar.config.currentMonthButtonImage, text: gtCalendar.config.currentMonthButtonTitle, titleColor: gtCalendar.config.monthButtonTitleColor)
        
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
        label.font = gtCalendar.config.monthButtonTitleFont
        view.addSubview(label)
        
        if text != nil {
            let size = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: label.font.lineHeight))
            view.widthAnchor.constraint(equalToConstant: size.width + 16).isActive = true
        } else {
            view.widthAnchor.constraint(equalToConstant: imageSize + 16).isActive = true
        }
        
        if image != nil {
            view.addSubview(imageView)
            imageView.image = image
            imageView.tintColor = titleColor
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: imageSize),
                imageView.heightAnchor.constraint(equalToConstant: imageSize),
                
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
            if text != nil {
                NSLayoutConstraint.activate([
                    label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 4),
                ])
            }
        } else {
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: button.trailingAnchor),
        ])
        
        view.bringSubviewToFront(button)
    }
}
