//
//  UIBarButtonItem + Extension.swift
//  BBS-iOS
//
//  Created by pengpeng on 16/6/5.
//  Copyright © 2016年 swift520. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(title: String, target: AnyObject?, action: Selector) {
        self.init(title: title, imageName: String(), target: target, action: action)
    }
    
    convenience init(imageName: String, target: AnyObject?, action: Selector) {
        self.init(title: String(), imageName: imageName, target: target, action: action)
    }
    
    convenience init(title: String, imageName: String, target: AnyObject?, action: Selector)
    {
        let btn = UIButton(type: .custom)
//        btn.backgroundColor = UIColor.randomColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
//        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -13, bottom: 0, right: 0)
        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: imageName), for: .highlighted)
        
//        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.sizeToFit()
        self.init(customView: btn)
    }
}

