//
//  CommentNetWorking.swift
//  BBS-iOS
//
//  Created by pengpeng on 2017/12/24.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import Moya

var commentProvider = MoyaProvider<CommentNetWorking>()

enum CommentNetWorking {
    case commentList(postId: Int)
    case createComment(content: String, userId: Int, postId: Int, quoteId: Int?)
//    ["content", "userId", "postId"], optionalParams: ["quoteId"])
}

extension CommentNetWorking: TargetType {
    var baseURL: URL { return URL(string: httpAdress)! }
    var path: String {
        switch self {
        case .commentList:
            return "commentList"
        case .createComment:
            return "createComment"
        }
    }
    var method: Moya.Method {
        switch self {
        case .commentList:
            return .post
        case .createComment:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .commentList(let postId):
            return .requestParameters(parameters: ["postId": postId], encoding: URLEncoding.httpBody)
        case .createComment(let content, let userId, let postId, let quoteId):
            
            var dict: [String: Any] = ["content": content, "userId": userId, "postId": postId]
            if let qi = quoteId {
                dict["quoteId"] = qi
            }
            return .requestParameters(parameters: dict, encoding: URLEncoding.httpBody)
        }
    }
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return nil
    }
}
