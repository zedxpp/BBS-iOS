//
//  UserModel.swift
//  BBS-iOS
//
//  Created by peng on 2017/12/12.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import ObjectMapper

class UserModel: Mappable {

    required init?(map: Map) {}
    
    var id: Int = 0
    var userPhone: String?
    var userNickName: String?
    var userIcon: String?
    
    var userCreateTime: Int = 0
    
    func mapping(map: Map) {
        id <- map["id"]
        userPhone <- map["userPhone"]
        userNickName <- map["userNickName"]
        userIcon <- map["userIcon"]
        userCreateTime <- map["userCreateTime"]
    }
}

