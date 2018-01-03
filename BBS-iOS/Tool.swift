//
//  Tool.swift
//  BBS-iOS
//
//  Created by pengpeng on 2017/11/23.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit

class Tool {
    static let projectName = "BBS_iOS"
    
    static func removeNameSpace(_ aClass: AnyClass) -> String {
        
        return NSStringFromClass(aClass).replacingOccurrences(of: projectName + ".", with: String())
    }
    
    static let screenW = UIScreen.main.bounds.size.width
    static let screenH = UIScreen.main.bounds.size.height
    
    
    static let keyWindow = UIApplication.shared.keyWindow!
    
    static var systemVersioniOS11Above: Bool {
        if #available(iOS 11.0, *) {
            return true
        }
        return false
    }
    
    static let isLogin = "isLogin"
    static let userId = "userId"
}

//let httpAdress = "http://0.0.0.0:8181/"
let httpAdress = "http://swift520.com:8181/"

func printLogFunc() {
    printLog(String())
}

func printLog<T>(_ message: T,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line) {
    //    #if DEBUG
    print("\((file as NSString).lastPathComponent) [\(line)] \(method): \(message)")
    //    #endif
}
