//
//  UIColor + Extension.swift
//  BBS-iOS
//
//  Created by pengpeng on 16/6/1.
//  Copyright © 2016年 swift520. All rights reserved.
//

import UIKit

extension UIColor {
//
    static var randomColor: UIColor{
            let red = CGFloat(arc4random_uniform(255)) / 255.0
            let green = CGFloat(arc4random_uniform(255)) / 255.0
            let blue = CGFloat(arc4random_uniform(255)) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
//
////    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
////        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
////    }
////
////    convenience init(rgb: CGFloat) {
////        self.init(red: rgb / 255.0, green: rgb / 255.0, blue: rgb / 255.0, alpha: 1)
////    }
//    
////    convenience init(color: UIColor, alpha: CGFloat) {
////
////        var r: CGFloat = 0
////        var g: CGFloat = 0
////        var b: CGFloat = 0
////
////        let cgColor = color.CGColor
////
////        let numComponents = CGColorGetNumberOfComponents(cgColor)
////        if numComponents == 4 {
////             let components = CGColorGetComponents(cgColor)
////            r = components[0]
////            g = components[1]
////            b = components[2]
////        }
////
////        self.init(red: r, green: g, blue: b, alpha: alpha)
////    }
//    
//    //用数值初始化颜色，便于生成设计图上标明的十六进制颜色
////    http://www.jianshu.com/p/fcfaba218d0c
////    convenience init(valueRGB: UInt) {
//
//    convenience init(hexString: String, alpha: CGFloat) {
//
//        let scanner = Scanner(string: hexString)
//        var hexNum: UInt32 = 0
//        if scanner.scanHexInt32(&hexNum) == false {
//            print("16进制转UIColor, hexString为空")
//        }
//        self.init(
//            red: CGFloat((hexNum & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((hexNum & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(hexNum & 0x0000FF) / 255.0,
//            alpha: CGFloat(alpha)
//        )
//    }
//
//    convenience init(hexString: String) {
//        self.init(hexString: hexString, alpha: 1.0)
//    }
//    
//    func xxxx() {
//        
//    }
//    
////    + (NSString *)hexStrWithColor:(UIColor *)color {
////    CGFloat r, g, b, a;
////    BOOL bo = [color getRed:&r green:&g blue:&b alpha:&a];
////    if (bo) {
////    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
////    return [NSString stringWithFormat:@"#%06x", rgb].uppercaseString;
////    } else {
////    return @"";
////    }
////    }
//    
////    convenience init(hexUInt: UInt) {
////        self.init(
////            red: CGFloat((hexUInt & 0xFF0000) >> 16) / 255.0,
////            green: CGFloat((hexUInt & 0x00FF00) >> 8) / 255.0,
////            blue: CGFloat(hexUInt & 0x0000FF) / 255.0,
////            alpha: CGFloat(1.0)
////        )
////    }
}

