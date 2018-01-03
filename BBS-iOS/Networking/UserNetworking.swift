//
//  UserNetworking.swift
//  BBS-iOS
//
//  Created by peng on 2017/12/28.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import Moya

var userProvider = MoyaProvider<UserNetworking>()

enum UserNetworking {
    case getUserInfo(postId: Int)
}

extension UserNetworking: TargetType {
    var baseURL: URL { return URL(string: httpAdress)! }
    var path: String {
        switch self {
        case .getUserInfo:
            return "getUserInfo"
        }
    }
    var method: Moya.Method {
        return .post
    }
    var task: Task {
        switch self {
        case .getUserInfo(let userId):
            return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.httpBody)
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String: String]? {
        return nil
    }
}



