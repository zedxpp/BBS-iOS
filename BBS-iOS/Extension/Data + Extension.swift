//
//  Data + Extension.swift
//  BBS-iOS
//
//  Created by peng on 2017/12/8.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit

extension Date {
    static var timeStamp: String {
        return String(Int(Date().timeIntervalSince1970))
    }
    
    static func date(_ timeStamp: String) -> String {
        return date(timeStamp, format: "yyyy-MM-dd HH:mm:ss")
    }
    
    static func date(_ timeStamp: String, format dateFormat: String) -> String {
        let fm = DateFormatter()
        fm.dateFormat = dateFormat
        fm.timeZone = TimeZone(identifier: "Asia/Shanghai")
        let str = fm.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp) ?? 0))
        return str
    }
    
}
