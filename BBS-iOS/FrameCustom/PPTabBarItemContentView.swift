//
//  PPTabBarItemContentView.swift
//  BBS-iOS
//
//  Created by peng on 2017/11/17.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class PPTabBarItemContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        highlightIconColor = UIColor.init(red: 37/255.0, green: 39/255.0, blue: 42/255.0, alpha: 1.0)
        
        
//        textColor = UIColor.init(white: 165.0 / 255.0, alpha: 1.0)
//        highlightTextColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
//        iconColor = UIColor.init(white: 165.0 / 255.0, alpha: 1.0)
//        highlightIconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
//        backdropColor = UIColor.init(red: 37/255.0, green: 39/255.0, blue: 42/255.0, alpha: 1.0)
//        highlightBackdropColor = UIColor.init(red: 22/255.0, green: 24/255.0, blue: 25/255.0, alpha: 1.0)
        
        let transform = CGAffineTransform.identity
        imageView.transform = transform.scaledBy(x: 1.15, y: 1.15)

    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("small", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = imageView.transform.scaledBy(x: 0.8, y: 0.8)
        imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("big", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = CGAffineTransform.identity
        imageView.transform = transform.scaledBy(x: 1.15, y: 1.15)
        UIView.commitAnimations()
        completion?()
    }
    
}
