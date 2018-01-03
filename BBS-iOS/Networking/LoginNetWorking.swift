//
//  LoginNetWorking.swift
//  BBS-iOS
//
//  Created by pengpeng on 2017/12/24.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import Moya

var loginProvider = MoyaProvider<LoginNetWorking>()

enum LoginNetWorking {
    case createUser(phone: String, password: String, nickname: String)
    case loginAccount(phone: String, password: String)
}

extension LoginNetWorking: TargetType {
    var baseURL: URL { return URL(string: httpAdress)! }
    var path: String {
        switch self {
        case .createUser:
            return "createUser"
        case .loginAccount:
            return "loginAccount"
        }
    }
    var method: Moya.Method {
        return .post
    }
    var task: Task {
        switch self {
        case .createUser(let phone, let password, let nickname):
            return .requestParameters(parameters: ["phone": phone, "password": password, "nickname": nickname], encoding: URLEncoding.httpBody)
        case .loginAccount(let phone, let password):
            return .requestParameters(parameters: ["phone": phone, "password": password], encoding: URLEncoding.httpBody)
        }
    }
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return nil
    }
}
