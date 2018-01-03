//
//  String + Extension.swift
//  BBS-iOS
//
//  Created by pengpeng on 16/6/5.
//  Copyright © 2016年 swift520. All rights reserved.
//

import UIKit
extension String {
//
//    /**
//     判断是否是纯数字
//     */
//    func isNumber() -> Bool {
//        let str = "^1\\d{10}$"
//        let regex = try! NSRegularExpression(pattern: str, options: NSRegularExpressionOptions(rawValue: 0))
//        let res = regex.numberOfMatchesInString(self, options: NSMatchingOptions(rawValue:0), range: NSMakeRange(0, self.characters.count))
//        
//        if res != 0 {
//            return true
//        }
//        return false
//    }
//    
   
    /// 在文件夹名前面插入缓存路径地址
    func insertCachesPath() -> String
    {
        let cachesPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        return (cachesPath as NSString).appendingPathComponent((self as NSString).pathComponents.last!)
    }
//
//    /**
//     获取文档文件夹夹路径
//     */
//    func documentPath() -> String
//    {
//        let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
//        return (documentPath as NSString).stringByAppendingPathComponent((self as NSString).pathComponents.last!)
//    }
//    
//    /**
//     获取临时文件夹路径
//     */
//    func temporaryPath() -> String
//    {
//        let temporaryPath = NSTemporaryDirectory()
//        return (temporaryPath as NSString).stringByAppendingPathComponent((self as NSString).pathComponents.last!)
//    }
}

