//
//  GTCalendar+Color.swift
//  pods_GTCalendar
//
//  Created by 風間剛男 on 2020/02/20.
//  Copyright © 2020 風間剛男. All rights reserved.
//

import UIKit

extension UIColor {

    static func rgb(_ rgbText:String) -> UIColor? {
        
        var matches:[String] = []
        if rgbText.pregMatche(pattern: "([a-fA-F0-9]{2,2})([a-fA-F0-9]{2,2})([a-fA-F0-9]{2,2})([a-fA-F0-9]{2,2})", matches: &matches) {
            guard let red = Int(matches[1], radix: 16) else {return nil}
            guard let green = Int(matches[2], radix: 16) else {return nil}
            guard let blue = Int(matches[3], radix: 16) else {return nil}
            guard let alpha = Int(matches[4], radix: 16) else {return nil}
            let color = UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
            return color
        }
        else if rgbText.pregMatche(pattern: "([a-fA-F0-9]{2,2})([a-fA-F0-9]{2,2})([a-fA-F0-9]{2,2})", matches: &matches) {
            guard let red = Int(matches[1], radix: 16) else {return nil}
            guard let green = Int(matches[2], radix: 16) else {return nil}
            guard let blue = Int(matches[3], radix: 16) else {return nil}
            let color = UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
            return color
        }
        return nil
    }
    
    
    open class var activeDefaultTextColor:UIColor {get {return UIColor.rgb("363636")!}}
    open class var nativeDefaultTextolor:UIColor {get {return UIColor.rgb("b3b3b3")!}}
    
    open class var activeRedTextColor:UIColor {get {return UIColor.rgb("db1168")!}}
    open class var activeBlueTextColor:UIColor {get {return UIColor.rgb("4858eb")!}}
    
    open class var nativeRedTextColor:UIColor {get {return UIColor.rgb("f3b7d2")!}}
    open class var nativeBlueTextClor:UIColor {get {return UIColor.rgb("bdcbfa")!}}
    
    open class var activeSelectCircleColor:UIColor {get {return UIColor.rgb("a1e6fe")!}}
    open class var nativeSelectCircleColor:UIColor {get {return UIColor.rgb("cde1e8")!}}
    
    open class var activeTodayCircleColor:UIColor {
        get {
            let color:UIColor = rgb("00ee00")!
            return color.withAlphaComponent(0.3)
        }
    }
    open class var nativeTodayCircleColor:UIColor {
        get {
            let color:UIColor = rgb("006600")!
            return color.withAlphaComponent(0.3)
        }
    }
    
    open class var backgroundClearColor:UIColor {
        get {
            let color:UIColor = .white
            return color.withAlphaComponent(0.01)
        }
    }
}
