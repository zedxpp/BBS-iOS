//
//  PostNetworking.swift
//  BBS-iOS
//
//  Created by peng on 2017/12/8.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import Moya

var postProvider = MoyaProvider<PostNetworking>()

enum PostNetworking {
//    case createUser(firstName: String, lastName: String)
    case postList(forumId: Int)
    case postDetails(postId: Int)
    case commentList(postId: Int)
}

extension PostNetworking: TargetType {
    var baseURL: URL { return URL(string: httpAdress)! }
    var path: String {
        switch self {
        case .postList:
            return "postList"
        case .postDetails:
            return "postDetails"
        case .commentList:
            return "commentList"
        }
    }
    var method: Moya.Method {
        switch self {
        case .postList:
            return .post
        case .postDetails:
            return .post
        case .commentList:
            return .post
        }
    }
    var task: Task {
        switch self {
//        case let .createUser(firstName, lastName): // Always send parameters as JSON in request body
//            return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: JSONEncoding.default)
        case let .postList(forumId):
            return .requestParameters(parameters: ["forumId": forumId], encoding: URLEncoding.httpBody)
        case let .postDetails(postId):
            return .requestParameters(parameters: ["postId": postId], encoding: URLEncoding.httpBody)
        case .commentList(let postId):
            return .requestParameters(parameters: ["postId": postId], encoding: URLEncoding.httpBody)
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String: String]? {
        //        return ["Content-type": "application/json"]
        return nil
    }
}


