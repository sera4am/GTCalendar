//
//  GTCalendar_Date.swift
//  pods_GTCalendar
//
//  Created by Sera Naoto on 2020/02/20.
//  Copyright © 2020 SHIJISHA. All rights reserved.
//

import UIKit

extension Date {
    
    
    internal func string(_ format:String = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSZ", locale:Locale? = Locale.current, timeZone:TimeZone? = TimeZone.current) -> String {
        let formatter = DateFormatter()
        if locale != nil {
            formatter.locale = locale!
        }
        if timeZone != nil {
            formatter.timeZone = timeZone!
        }
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    init?(_ dateString:String, _ format:String = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSZ", locale:Locale? = Locale.current, timeZone:TimeZone? = TimeZone.current) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if locale != nil {
            formatter.locale = locale!
        }
        if timeZone != nil {
            formatter.timeZone = timeZone!
        }
        guard let date = formatter.date(from: dateString) else { return nil }
        self = date
    }
    
    internal func yearMonth(_ format:String = "MMM yyyy", locale:Locale? = Locale.current, timeZone:TimeZone? = TimeZone.current) -> String {
        return string(format, locale: locale, timeZone: timeZone)
    }
    
    internal func year(_ timeZone:TimeZone? = TimeZone.current) -> Int {
        var calendar = Calendar.current
        if timeZone != nil {
            calendar.timeZone = timeZone!
        }
        return calendar.component(.year, from: self)
    }
    
    internal func month(_ timeZone:TimeZone? = TimeZone.current) -> Int {
        var calendar = Calendar.current
        if timeZone != nil {
            calendar.timeZone = timeZone!
        }
        return calendar.component(.month, from: self)
    }
    
    internal func day(_ timeZone:TimeZone? = TimeZone.current) -> Int {
        var calendar = Calendar.current
        if timeZone != nil {
            calendar.timeZone = timeZone!
        }
        return calendar.component(.day, from: self)
    }
    
    internal func hour(_ timeZone:TimeZone? = TimeZone.current) -> Int {
        var calender = Calendar.current
        if timeZone != nil {
            calender.timeZone = timeZone!
        }
        return calender.component(.hour, from: self)
    }
    
    internal func minute(_ timeZone:TimeZone? = TimeZone.current) -> Int {
        var calendar = Calendar.current
        if timeZone != nil {
            calendar.timeZone = timeZone!
        }
        return calendar.component(.minute, from: self)
    }
    
    internal func second(_ timeZone:TimeZone? = TimeZone.current) -> Int {
        var calendar = Calendar.current
        if timeZone != nil {
            calendar.timeZone = timeZone!
        }
        return calendar.component(.second, from: self)
    }
    
    internal func milliseconds(_ timeZone:TimeZone? = TimeZone.current) -> Int {
        var calendar = Calendar.current
        if timeZone != nil {
            calendar.timeZone = timeZone!
        }
        return Int(floor(Double(calendar.component(.nanosecond, from: self)) / 1000000.0))
    }
    
    internal func weekOfMonth(_ timeZone:TimeZone? = TimeZone.current) -> Int {
        var calendar = Calendar.current
        if timeZone != nil {
            calendar.timeZone = timeZone!
        }
        return calendar.component(.weekOfMonth, from: self)
    }
    
    internal func dayOfWeek(_ timeZone:TimeZone? = TimeZone.current) -> Int {
        var calendar = Calendar.current
        if timeZone != nil {
            calendar.timeZone = timeZone!
        }
        return calendar.component(.weekday, from: self)
    }
    
    internal func firstDayOfWeek(_ timeZone:TimeZone? = TimeZone.current) -> Date {
        var calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = month()
        dateComponents.year = year()
        dateComponents.weekday = 1
        dateComponents.weekdayOrdinal = weekOfMonth()
        
        if timeZone != nil {
            dateComponents.timeZone = timeZone!
            calendar.timeZone = timeZone!
        }
        
        return calendar.date(from: dateComponents)!
    }
    
    internal func firstDayOfMonth(_ timeZone:TimeZone? = TimeZone.current) -> Date {
        var calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = month()
        dateComponents.year = year()
        dateComponents.day = 1
        
        if timeZone != nil {
            dateComponents.timeZone = timeZone!
            calendar.timeZone = timeZone!
        }
        
        return calendar.date(from: dateComponents)!
    }
    
    internal func dayStart(_ timeZone:TimeZone? = TimeZone.current) -> Date {
        var calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = month()
        dateComponents.year = year()
        dateComponents.day = day()
        
        if timeZone != nil {
            dateComponents.timeZone = timeZone!
            calendar.timeZone = timeZone!
        }
        return calendar.date(from: dateComponents)!
    }
    
    internal func lastDayOfMonth(_ timeZone:TimeZone? = TimeZone.current) -> Date {
        var calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year()
        dateComponents.month = month() + 1
        dateComponents.day = -1
        
        if timeZone != nil {
            calendar.timeZone = timeZone!
            dateComponents.timeZone = timeZone!
        }
        return calendar.date(from: dateComponents)!
    }
    
    init(_ month:Date, _ weekOfMonth:Int, _ dayOfWeek:Int, timeZone:TimeZone? = TimeZone.current) {
        var calenadr = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = month.year()
        dateComponents.month = month.month()
        dateComponents.weekOfMonth = weekOfMonth
        dateComponents.weekday = dayOfWeek
        
        if timeZone != nil {
            calenadr.timeZone = timeZone!
            dateComponents.timeZone = timeZone!
        }
        self = calenadr.date(from: dateComponents)!
    }
    
    internal func add(_ type:Calendar.Component, _ value:Int, timeZone:TimeZone? = TimeZone.current) -> Date? {
        var date:Date? = nil
        var calendar = Calendar.current
        
        if timeZone != nil {
            calendar.timeZone = timeZone!
        }
        
        switch type {
        case .year:
            date = calendar.date(byAdding: .year, value: value, to: self)
            break
        case .month:
            date = calendar.date(byAdding: .month, value: value, to: self)
            break
        case .day:
            date = calendar.date(byAdding: .day, value: value, to: self)
            break
        case .hour:
            date = calendar.date(byAdding: .hour, value: value, to: self)
            break
        case .minute:
            date = calendar.date(byAdding: .minute, value: value, to: self)
            break
        case .second:
            date = calendar.date(byAdding: .second, value: value, to: self)
            break
        case .weekOfMonth:
            date = calendar.date(byAdding: .weekOfMonth, value: value, to: self)
            break
        default:
            break
        }
        
        return date
    }
    
    internal static func == (lhs:Date, rhs:Date) -> Bool {
        return lhs.dayStart().compare(rhs.dayStart()) == .orderedSame
    }
    
    internal static func != (lhs:Date, rhs:Date) -> Bool {
        return !(lhs == rhs)
    }
    
    internal static func > (lhs:Date, rhs:Date) -> Bool {
        return lhs.dayStart().compare(rhs.dayStart()) == .orderedDescending
    }
    
    internal static func < (lhs:Date, rhs:Date) -> Bool {
        return lhs.dayStart().compare(rhs.dayStart()) == .orderedAscending
    }
    
    internal static func >= (lhs:Date, rhs:Date) -> Bool {
        return lhs == rhs || lhs > rhs
    }
    
    internal static func <= (lhs:Date, rhs:Date) -> Bool {
        return lhs == rhs || lhs < rhs
    }
}
