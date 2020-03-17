//
//  GTCalender+Print.swift
//  pods_GTCalendar
//
//  Created by 風間剛男 on 2020/02/20.
//  Copyright © 2020 風間剛男. All rights reserved.
//

import UIKit

func print(value:Any...) {
    var vals = value
    vals.insert(Date().string("[HH:mm:ss]"), at: 0)
    Swift.print(vals)
}
