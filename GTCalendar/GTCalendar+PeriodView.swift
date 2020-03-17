//
//  GTCalendar+PeriodView.swift
//  pods_GTCalendar
//
//  Created by 風間剛男 on 2020/03/16.
//  Copyright © 2020 風間剛男. All rights reserved.
//

import UIKit

@IBDesignable
class GTCalendar_PeriodView: UIView {

    var gtCalendar:GTCalendar!
    var stackView:UIStackView = UIStackView()
    var startView:UIView = UIView()
    var toView:UIView = UIView()
    var endView:UIView = UIView()
    var startStackView:UIStackView = UIStackView()
    var endStackView:UIStackView = UIStackView()
    var startHeaderLabel:UILabel = UILabel()
    var endHeaderLabel:UILabel = UILabel()
    var startLabel:UILabel = UILabel()
    var endLabel:UILabel = UILabel()
    var toLabel:UILabel = UILabel()
    var startButton:UIButton = UIButton()
    var endButton:UIButton = UIButton()
    var selectorBar:UIView = UIView()
    var toWidthContstraint:NSLayoutConstraint? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        initView()
    }
    
    func initView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        startView.translatesAutoresizingMaskIntoConstraints = false
        endView.translatesAutoresizingMaskIntoConstraints = false
        startStackView.translatesAutoresizingMaskIntoConstraints = false
        endStackView.translatesAutoresizingMaskIntoConstraints = false
        startHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        endHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        endLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        endButton.translatesAutoresizingMaskIntoConstraints = false
//        selectorBar.translatesAutoresizingMaskIntoConstraints = false
        toView.translatesAutoresizingMaskIntoConstraints = false
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        
        startView.backgroundColor = .clear
        endView.backgroundColor = .clear
        
        self.addSubview(selectorBar)
        
        self.addSubview(stackView)
        self.addConstraints([
            NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: stackView, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8

        stackView.addArrangedSubview(startView)
        stackView.addArrangedSubview(toView)
        stackView.addArrangedSubview(endView)
        startView.addSubview(startStackView)
        endView.addSubview(endStackView)
        
        stackView.addConstraint(NSLayoutConstraint(item: startView, attribute: .width, relatedBy: .equal, toItem: endView, attribute: .width, multiplier: 1, constant: 0))
        toWidthContstraint = NSLayoutConstraint(item: toView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 0)
        toView.addConstraint(toWidthContstraint!)
        
        toView.addSubview(toLabel)
        toView.addConstraints([
            NSLayoutConstraint(item: toLabel, attribute: .centerX, relatedBy: .equal, toItem: toView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: toLabel, attribute: .centerY, relatedBy: .equal, toItem: toView, attribute: .centerY, multiplier: 1, constant: 0)
        ])
        
        startView.addConstraints([
            NSLayoutConstraint(item: startStackView, attribute: .top, relatedBy: .equal, toItem: startView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: startView, attribute: .bottom, relatedBy: .equal, toItem: startStackView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: startStackView, attribute: .leading, relatedBy: .equal, toItem: startView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: startView, attribute: .trailing, relatedBy: .equal, toItem: startStackView, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        endView.addConstraints([
            NSLayoutConstraint(item: endStackView, attribute: .top, relatedBy: .equal, toItem: endView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: endView, attribute: .bottom, relatedBy: .equal, toItem: endStackView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: endStackView, attribute: .leading, relatedBy: .equal, toItem: endView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: endView, attribute: .trailing, relatedBy: .equal, toItem: endStackView, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        
        startStackView.axis = .vertical
        startStackView.distribution = .fillEqually
        endStackView.axis = .vertical
        endStackView.distribution = .fillEqually
        
        startStackView.addArrangedSubview(startLabel)
        startStackView.addArrangedSubview(startHeaderLabel)
        endStackView.addArrangedSubview(endLabel)
        endStackView.addArrangedSubview(endHeaderLabel)

        startView.addSubview(startButton)
        endView.addSubview(endButton)
        
        startView.addConstraints([
            NSLayoutConstraint(item: startButton, attribute: .top, relatedBy: .equal, toItem: startView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: startView, attribute: .bottom, relatedBy: .equal, toItem: startButton, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: startButton, attribute: .leading, relatedBy: .equal, toItem: startView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: startView, attribute: .trailing, relatedBy: .equal, toItem: startButton, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        endView.addConstraints([
            NSLayoutConstraint(item: endButton, attribute: .top, relatedBy: .equal, toItem: endView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: endView, attribute: .bottom, relatedBy: .equal, toItem: endButton, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: endButton, attribute: .leading, relatedBy: .equal, toItem: endView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: endView, attribute: .trailing, relatedBy: .equal, toItem: endButton, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        
        startHeaderLabel.textAlignment = .center
        endHeaderLabel.textAlignment = .center
        startLabel.textAlignment = .center
        endLabel.textAlignment = .center
        
        startView.bringSubviewToFront(startButton)
        endView.bringSubviewToFront(endButton)
        
        startButton.addTarget(self, action: #selector(onSelector(_:)), for: .touchUpInside)
        endButton.addTarget(self, action: #selector(onSelector(_:)), for: .touchUpInside)
        
        reloadData()
    }
    
    @objc func onSelector(_ sender:UIButton) {
        switch sender {
        case startButton:
            gtCalendar.periodSelectionTarget = .Start
            break
        case endButton:
            gtCalendar.periodSelectionTarget = .End
        default:
            break
        }
    }
    
    func changeSelector(_ animate:Bool = true) {
        
        var frame:CGRect!
        
        switch gtCalendar.periodSelectionTarget {
        case .Start:
            frame = CGRect(
                x: 0,
                y: startButton.frame.origin.y + startButton.frame.height - 4,
                width: startButton.frame.width,
                height: 2
            )
            break
        case .End:

            frame = CGRect(
                x: startButton.frame.width + toView.frame.width + 16,
                y: endButton.frame.origin.y + endButton.frame.height - 4,
                width: endButton.frame.width,
                height: 2
            )
            break
        }
        
        UIView.animate(withDuration: animate ? 0.2 : 0.0) {
            self.selectorBar.frame = frame
            self.startHeaderLabel.textColor = self.gtCalendar.periodTitleTextColor
            self.endHeaderLabel.textColor = self.gtCalendar.periodTitleTextColor
            switch self.gtCalendar.periodSelectionTarget {
            case .Start:
                self.startHeaderLabel.textColor = self.gtCalendar.periodSelectedTitleTextColor
                break
            case .End:
                self.endHeaderLabel.textColor = self.gtCalendar.periodSelectedTitleTextColor
                break
            }
        }
        
    }
    
    func reloadData() {
        
        selectorBar.backgroundColor = gtCalendar.periodSelectorbarColor
        
        startHeaderLabel.text = gtCalendar.periodStartTitle
        endHeaderLabel.text = gtCalendar.periodEndTitle
        
        startHeaderLabel.font = gtCalendar.periodTitleFont
        endHeaderLabel.font = gtCalendar.periodTitleFont
        startHeaderLabel.textColor = gtCalendar.periodTitleTextColor
        endHeaderLabel.textColor = gtCalendar.periodTitleTextColor
        
        
        startLabel.font = gtCalendar.periodDateFont
        endLabel.font = gtCalendar.periodDateFont
        startLabel.textColor = gtCalendar.periodDateTextColor
        endLabel.textColor = gtCalendar.periodDateTextColor
        
        toLabel.text = gtCalendar.periodToText
        toLabel.font = gtCalendar.periodToFont
        toLabel.textColor = gtCalendar.periodToTextColor
        
        let toSize = toLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30))
        toWidthContstraint?.constant = toSize.width + 32
        
        startLabel.text = ""
        if gtCalendar.startDate != nil {
            startLabel.text = gtCalendar.startDate!.string(gtCalendar.periodDateFormat)
        } else {
            startLabel.text = gtCalendar.periodDateminedText
            startLabel.textColor = gtCalendar.periodDateminedTextColor
        }
        endLabel.text = ""
        if gtCalendar.endDate != nil {
            endLabel.text = gtCalendar.endDate!.string(gtCalendar.periodDateFormat)
        } else {
            endLabel.text = gtCalendar.periodDateminedText
            endLabel.textColor = gtCalendar.periodDateminedTextColor
        }
        
        changeSelector(false)
    }
    
}
