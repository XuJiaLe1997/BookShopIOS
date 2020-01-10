//
//  AppDelegate.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/17.
//  Copyright © 2019 xujiale. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // 屏幕旋转与禁止旋转
    var isForceLandscape:Bool = false       // 横屏
    var isForcePortrait:Bool = false        // 竖屏
    var isForceAllDerictions:Bool = false   // 支持所有屏幕方向

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        CommonUtil.loadBooks()
        CommonUtil.loadUsers()
        initTheme()
        return true
    }
    
    fileprivate func initTheme() {
        
        ThemeManager.setTheme(plistName: "Red", path: .mainBundle)
        
        // 顶部状态栏
        UIApplication.shared.theme_setStatusBarStyle("UIStatusBarStyle", animated: true)
        
        // 导航栏样式
        let navigationBar = UINavigationBar.appearance()
        navigationBar.theme_tintColor = "Global.barTextColor"
        navigationBar.theme_barTintColor = "Global.barTintColor"
        navigationBar.isTranslucent = false // 不使用模糊
        navigationBar.theme_titleTextAttributes = ThemeStringAttributesPicker(keyPath: "Global.barTextColor") { value -> [NSAttributedString.Key : AnyObject]? in
            guard let rgba = value as? String else {
                return nil
            }
            
            let color = UIColor(rgba: rgba)
            let shadow = NSShadow(); shadow.shadowOffset = CGSize.zero
            let titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: color,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.shadow: shadow
            ]
            
            return titleTextAttributes
        }
        
        // toolbar样式，本例有部分页面使用toolbar
        let toolBar = UIToolbar.appearance()
//        toolBar.theme_tintColor = "Global.barTextColor"
//        toolBar.theme_barTintColor = "Global.barTintColor"
        toolBar.isTranslucent = false
        
        // tabbar样式
        let tabBar = UITabBar.appearance()
        tabBar.theme_tintColor = "Global.tabTextColor"
        tabBar.theme_barTintColor = "Global.tabTintColor"
        tabBar.isTranslucent = false
        
        // tabBarItem样式，若使用故事板推荐25*25的icon
        let tabBarItem = UITabBarItem.appearance()
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0)], for: .normal)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if isForceAllDerictions {
            return .all
        } else if isForceLandscape {
            return .landscape
        } else if isForcePortrait {
            return .portrait
        }
        // 默认是竖屏
        return .portrait
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

