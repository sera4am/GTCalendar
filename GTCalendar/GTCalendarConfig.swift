//
//  GTCalendarConfig.swift
//  GTCalendar
//
//  Created by Sera Naoto on 2020/07/20.
//  Copyright © 2020 SHIJISHA. All rights reserved.
//

import UIKit

open class GTCalendarConfig {

    public init() {}

    /**
     It is used when selecting the date of the range.
     After start is determined, the next selection is automatically set to end.
     
     Note:
     If "false" this property.
     Developer must get the "Delegate" receive and set the "periodSelectionTarget"
     appropriately to explicitly switch between the StartDate and EndDate inputs.
     */
    open var periodSelectionAuto:Bool = false
    
    /**
     Text color of the date label for the current month
     */
    open var activeTextColor:UIColor = .black
    
    /**
     Text color of the date label other than current month
     */
    open var nativeTextColor:UIColor = .gray
    
    /**
     Text format of the month on the calendar header
     */
    open var monthlyHeaderTitleDateFormat:String = "MMM yyyy"
    
    /**
     Text color of the month on the calendar header
     */
    open var monthlyHeaderTitleTextColor:UIColor = .black
    
    /**
     Font type of the month on the calendar header
     */
    open var monthlyHeaderTitleFont:UIFont = UIFont(name: "Arial", size: 18.0)!
    
    /**
     Font type of the date label for the current month
     */
    open var activeFont:UIFont = UIFont(name: "Arial", size: 14.0)!
    
    /**
     Font type of the date label other than current month
     */
    open var nativeFont:UIFont = UIFont(name: "Arial", size: 12.0)!
    
    /**
     Font type of the sub title label below date label for the current month
     
     Note:
     Text color uses the same color as thats date label
     */
    open var activeSubLabelFont:UIFont = UIFont(name: "Arial", size: 10.0)!
    
    /**
     Font type of the sub title label below date label other than current month
     
     Note:
     Text color uses the same color as thats date label
     */
    open var nativeSubLabelFont:UIFont = UIFont(name: "Arial", size: 8.0)!
    
    /**
     Time zone for the calendar uses
     */
    open var timeZone:TimeZone = TimeZone.current
    
    /**
     Text of the week day label for the calendar header
     */
    open var weekdayText:[String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    /**
     Text color of the week day label for the calendar header (on weekdays)
     */
    open var weekdayTextColor:UIColor = .activeDefaultTextColor
    
    /**
     Font type of the week day label for the calendar header
     */
    open var weekdayFont:UIFont = UIFont(name: "arial", size: 9.0)!
    
    /**
     Text color of week day label for the calendar header (on sunday)
     */
    open var weekdaySundayTextColor:UIColor = .activeRedTextColor
    
    /**
     Text color of tweek day label for the calendar header (on saturday
     */
    open var weekdaySaturdayTextColor:UIColor = .activeBlueTextColor
    
    /**
     Text color of the day label for the calendar header (on saturday)
     
     Note:
     If set null then, uses activeTextColof value
     */
    open var saturdayTextColor:UIColor? = .activeBlueTextColor
    
    /**
     Text color of the day label for the calendar header (on sunday)
     
     Note:
     If set null then, uses activeTextColor value
     */
    open var sundayTextColor:UIColor? = .activeRedTextColor
    
    /**
     Text color of the native day label for the calendar header (on saturday)
     
     Note:
     If set null then, uses nativeTextColor value
     */
    open var saturdayNativeTextColor:UIColor? = .nativeBlueTextClor
    
    /**
     Text color of the date labe (other than current month)l for the calendar heaader (on sunday)
     
     Note:
     If set null then, uses nativeTextColor value
     */
    open var sundayNativeTextColor:UIColor? = .nativeRedTextColor
    
    /**
     Color of selected day circle
     */
    open var activeSelectCircleColor:UIColor? = .activeSelectCircleColor
    
    /**
     Color of selected day's circle, other than current month
     */
    open var nativeSelectCircleColor:UIColor? = .nativeSelectCircleColor
    
    /**
     Color of  the today circle
     */
    open var activeTodayCircleColor:UIColor? = .activeTodayCircleColor
    
    /**
     Color of the today circle, other than current month
     */
    open var nativeTodayCircleColor:UIColor? = .nativeTodayCircleColor
    
    /**
     Title for the button to move to previos month
     */
    open var prevMonthButtonTitle:String? = "Prev Mon"
    
    /**
     Title for the button to move to next month
     */
    open var nextMonthButtonTitle:String? = "Next Mon"
    
    /**
     Title for the button to move to current month
     */
    open var currentMonthButtonTitle:String? = "Current Mon"
    
    /**
     Image for the button to move to previos month
     */
    open var prevMonthButtonImage:UIImage? = nil
    
    /**
     Image for the button to move to next month
     */
    open var nextMonthButtonImage:UIImage? = nil
    
    /**
     Image for the button to move to current month
     */
    open var currentMonthButtonImage:UIImage? = nil
    
    /**
     Title color for the button to month control
     */
    open var monthButtonTitleColor:UIColor = .blue
    
    /**
     Font type for the button to month control
     */
    open var monthButtonTitleFont:UIFont = UIFont(name: "Arial", size: 10.0)!
    
    /**
     Title color for the button, if that exceeds the effective range
     */
    open var monthButtonNativeTitleColor:UIColor = .nativeDefaultTextolor
    
}

