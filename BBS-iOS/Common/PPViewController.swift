//
//  PPViewController.swift
//  BBS-iOS
//
//  Created by peng on 2017/11/23.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PPViewController: UIViewController, NVActivityIndicatorViewable {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
    }
    
    
    func startAnimating() {
        
        startAnimating(CGSize(width: 25, height: 25), type: .lineSpinFadeLoader, color: UIColor.red, backgroundColor: UIColor.clear)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
