//
//  PPNavigationController.swift
//  BBS-iOS
//
//  Created by peng on 2017/11/23.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit

class PPNavigationController: UINavigationController, UIGestureRecognizerDelegate {//

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
        
        navigationBar.setBackgroundImage(UIImage(named: "nav_bgImage"), for: .default)
//        navigationBar.shadowImage = UIImage()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count != 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .done, target: self, action: #selector(self.back))
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc fileprivate func back() {
        popViewController(animated: true)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
