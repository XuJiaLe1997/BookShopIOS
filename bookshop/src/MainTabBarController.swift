//
//  MainTabBarController.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/20.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            NotificationCenter.default.post(name: NSNotification.Name("refreshShoppingCar"), object: nil)
            break
        default:
            break
        }
    }
}
