//
//  GTCalendar+JPHoliday.swift
//  pods_GTCalendar
//
//  Created by Sera Naoto on 2020/03/17.
//  Copyright © 2020 SHIJISHA. All rights reserved.
//

import UIKit

class GTCalendar_JPHolidayData {
    
}

@IBDesignable
public class GTCalendar_JPHoliday: GTCalendar {

    private let gitURL:String = "https://raw.githubusercontent.com/holiday-jp/holiday_jp/master/holidays.yml"
    private var holidayData:[String:String] = [:]
    private var isLoading:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadHoliday()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadHoliday()
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        loadHoliday()
    }
    
    func clearHoliday() {
        
    }
    
    private func loadHoliday() {
        guard let data = UserDefaults.standard.dictionary(forKey: "gt_calendar_holiday_jp") as? [String:String] else {
            getHolidayFromGit()
            return
        }
        holidayData = data
        reloadPages()
    }
    
    private func getHolidayFromGit() {
        if isLoading { return }
        isLoading = true
        guard let url = URL(string: gitURL) else { return }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error != nil || data == nil {
                self.isLoading = false
                return
            }
            let text = String(data: data!, encoding: .utf8)
            
            text?.components(separatedBy: "\n").forEach({ line in
                let dateName = line.components(separatedBy: ":")
                if dateName.count == 2 {
                    if let date = Date(dateName[0], "yyyy'-'MM'-'dd") {
                        print("[Holiday]", dateName)
                        self.holidayData[date.string("yyyy'-'MM'-'dd")] = dateName[1]
                    }
                }
            })
            if self.holidayData.count > 0 {
                UserDefaults.standard.set(self.holidayData, forKey: "gt_calendar_holiday_jp")
                UserDefaults.standard.synchronize()
                DispatchQueue.main.async {
                    self.reloadPages()
                }
            }
            self.isLoading = false
        }.resume()
    }
    
    override public func isHoliday(date: Date) -> String? {
        let nDate = date.string("yyyy-MM-dd")
        print(nDate)
        if holidayData[nDate] != nil {
            return holidayData[nDate]
        }
        return nil
    }
    
}
