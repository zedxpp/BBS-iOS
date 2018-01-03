//
//  ForumNetworking.swift
//  BBS-iOS
//
//  Created by peng on 2017/12/27.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import Moya

var forumProvider = MoyaProvider<ForumNetworking>()

enum ForumNetworking {
    case forumList
}

extension ForumNetworking: TargetType {
    var baseURL: URL { return URL(string: httpAdress)! }
    var path: String {
        switch self {
        case .forumList:
            return "forumList"
        }
    }
    var method: Moya.Method {
        return .post
    }
    var task: Task {
        switch self {
        case .forumList:
            return .requestPlain
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String: String]? {
        return nil
    }
}
