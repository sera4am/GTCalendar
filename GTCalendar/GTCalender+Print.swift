//
//  GTCalender+Print.swift
//  pods_GTCalendar
//
//  Created by Sera Naoto on 2020/02/20.
//  Copyright © 2020 SHIJISHA. All rights reserved.
//

import UIKit

func print(value:Any...) {
    var vals = value
    vals.insert(Date().string("[HH:mm:ss]"), at: 0)
    Swift.print(vals)
}
