//
//  NSAttributedString + Extension.swift
//  BBS-iOS
//
//  Created by peng on 2017/11/28.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    /// 富文本转html字符串
    ///
    /// - Returns: html字符串
    func html() -> String {
        let params: [NSAttributedString.DocumentAttributeKey : Any] = [DocumentAttributeKey.documentType: DocumentType.html,
                                            DocumentAttributeKey.characterEncoding: String.Encoding.utf8.rawValue]
        
        do {
            let htmlData = try data(from: NSMakeRange(0, length), documentAttributes: params)
            let res = String(data: htmlData, encoding: String.Encoding.utf8) ?? String()
            return res
        } catch {
            print(error.localizedDescription)
            return String()
            
        }
    }
}

extension String {

    /// html字符串转富文本
    ///
    /// - Returns: 富文本
    func attributedString() -> NSAttributedString {
        do {

            let htmlData = data(using: String.Encoding.unicode, allowLossyConversion: true)
            
            var res = NSAttributedString()
            
            guard let availableData = htmlData else {
                return res
            }
            
            res = try NSAttributedString(data: availableData, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            return res

        } catch let error as NSError {
            print(error.localizedDescription)
            return NSAttributedString()
        }
    }
}
