//
//  CommentModel.swift
//  BBS-iOS
//
//  Created by pengpeng on 2017/12/24.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import ObjectMapper

class CommentModel: Mappable {
    required init?(map: Map) {}
    
    var commentContent: String?

    var commentPostId: Int = 0
    var commentUserId: Int = 0
    var id: Int = 0
    var commentQuoteId: Int = 0
    var commentFloor: Int = 0
    var commentCreateTime: Int = 0
    
    var user: UserModel?
    
    var quoteComment: CommentModel?

    func mapping(map: Map) {
        commentContent <- map["commentContent"]
        commentPostId <- map["commentPostId"]
        commentUserId <- map["commentUserId"]
        commentQuoteId <- map["commentQuoteId"]
        commentFloor <- map["commentFloor"]
        id <- map["id"]
        commentCreateTime <- map["commentCreateTime"]
        user <- map["user"]
        quoteComment <- map["quoteComment"]
    }
}
