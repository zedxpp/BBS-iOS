//
//  User.swift
//  BBS-iOS
//
//  Created by peng on 2017/12/27.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit

class User: NSObject {
    static var userId: String {
        let tmp = UserDefaults.standard.object(forKey: Tool.userId) as? String
        return tmp ?? ""
    }
}
