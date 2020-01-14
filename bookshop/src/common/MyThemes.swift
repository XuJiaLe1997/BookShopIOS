//
//  MyTheme.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/10.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation

enum MyThemes: String {
    
    case red    = "Red"
    case night  = "Night"
    case blue   = "Blue"
    case green  = "Green"
    case yellow = "Yellow"
    
    static func switchTo(_ theme: MyThemes) {
        UserDefaults.AppInfo.set(value: theme.rawValue, forKey: .themeStyle)
        ThemeManager.setTheme(plistName: theme.rawValue, path: .mainBundle)
    }
    
}
