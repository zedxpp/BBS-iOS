//
//  AppDelegate.swift
//  BBS-iOS
//
//  Created by peng on 2017/11/17.
//  Copyright © 2017年 swift520. All rights reserved.
//

import UIKit
import ESTabBarController_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
//        if #available(iOS 11.0, *) {
//            UIScrollView.appearance().contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
//            UITableView.appearance().estimatedRowHeight = 0;
//            UITableView.appearance().estimatedSectionFooterHeight = 0;
//            UITableView.appearance().estimatedSectionHeaderHeight = 0;
//        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let bo = UserDefaults.standard.bool(forKey: Tool.isLogin)
        if bo {
            window?.rootViewController = setupTabbarController()
        } else {
            let loginVC = LoginViewController.loginViewController()!
            loginVC.loginSuccess = {
                self.window?.rootViewController = self.setupTabbarController()
            }
            
            let nav = PPNavigationController(rootViewController: loginVC)
            
            
            window?.rootViewController = nav
        }
    
        window?.makeKeyAndVisible()
        
        

        return true
    }
    
    func setupTabbarController() -> ESTabBarController {
        let tabBarController = ESTabBarController()
        if let tabBar = tabBarController.tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = .fillIncludeSeparator
        }
        
        let postList = PostListViewController()
        let forumList = ForumListViewController()
//        let postDetails = PostDetailsViewController()
        let userInfo = UserInformationViewController()
        
        postList.tabBarItem = ESTabBarItem.init(PPTabBarItemContentView(), title: nil, image: UIImage(named: "postList"), selectedImage: UIImage(named: "postList"))
        forumList.tabBarItem = ESTabBarItem.init(PPTabBarItemContentView(), title: nil, image: UIImage(named: "forumList"), selectedImage: UIImage(named: "forumList"))
//        postDetails.tabBarItem = ESTabBarItem.init(PPTabBarItemContentView(), title: nil, image: UIImage(named: "photo"), selectedImage: UIImage(named: "photo_1"))
        userInfo.tabBarItem = ESTabBarItem.init(PPTabBarItemContentView(), title: nil, image: UIImage(named: "my"), selectedImage: UIImage(named: "my"))
        
        let n1 = PPNavigationController(rootViewController: postList)
        let n2 = PPNavigationController(rootViewController: forumList)
//        let n3 = PPNavigationController(rootViewController: postDetails)
        let n4 = PPNavigationController(rootViewController: userInfo)
        
//        tabBarController.viewControllers = [n1, n2, n3, n4]
        tabBarController.viewControllers = [n1, n2, n4]
//        tabBarController.viewControllers = [n3, n2, n1, n4]
//        tabBarController.viewControllers = [n4, n1, n2, n3]
        
        return tabBarController
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

