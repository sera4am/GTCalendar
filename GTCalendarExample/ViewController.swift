//
//  ViewController.swift
//  GTCalendarExample
//
//  Created by 風間剛男 on 2020/05/09.
//  Copyright © 2020 世来直人. All rights reserved.
//

import UIKit
import GTCalendar

class ViewController: UIViewController {

    @IBOutlet weak var calendar: GTCalendar_JPHoliday!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendar.selectionType = .Period
        
        let config = GTCalendarConfig()
            
        
        config.monthlyHeaderTitleDateFormat = "yyyy年M月"
        
        config.weekdayText = ["日", "月", "火", "水", "木", "金", "土"]
        
        config.prevMonthButtonTitle = nil
        config.prevMonthButtonImage = UIImage(systemName: "arrow.left.to.line")
        
        config.nextMonthButtonTitle = nil
        config.nextMonthButtonImage = UIImage(systemName: "arrow.right.to.line.alt")
        
        config.currentMonthButtonTitle = nil
        config.currentMonthButtonImage = UIImage(systemName: "calendar.circle.fill")
        
        config.periodSelectionAuto = true
        
        calendar.config = config
        
    }

    override func viewDidAppear(_ animated: Bool) {
        calendar.moveTo(Date(timeIntervalSince1970: 0))
    }

}

