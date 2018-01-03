//
//  ForumModel.swift
//  BBS-iOS
//
//  Created by peng on 2017/12/27.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import ObjectMapper

class ForumModel: Mappable {
    required init?(map: Map) {}
    
    var id: Int = 0
    var forumName: String?
    var forumManager: String?
    var forumIcon: String?
    var forumCreateTime: Int = 0
    var forumDes: String?
    
    func mapping(map: Map) {
        id <- map["id"]
        forumName <- map["forumName"]
        forumManager <- map["forumManager"]
        forumCreateTime <- map["forumCreateTime"]
        forumIcon <- map["forumIcon"]
        forumDes <- map["forumDes"]
    }
}
