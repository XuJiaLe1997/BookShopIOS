//
//  MyTheme.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/10.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation

enum MyThemes: Int {
    
    case red   = 0
    case night = 1
    
    static var current = MyThemes.red
    static var before  = MyThemes.red
    
    static func switchTo(_ theme: MyThemes) {
        before  = current
        current = theme
        
        switch theme {
        case .red   : ThemeManager.setTheme(plistName: "Red", path: .mainBundle)
        case .night : ThemeManager.setTheme(plistName: "Night", path: .mainBundle)
        }
    }
    
    static func switchToNext() {
        var next = current.rawValue + 1
        let max  = 1 // without Night
        
        if next >= max { next = 0 }
        
        switchTo(MyThemes(rawValue: next)!)
    }
    
    // MARK: - Switch Night
    
    static func switchNight(_ isToNight: Bool) {
        switchTo(isToNight ? .night : before)
    }
    
    static func isNight() -> Bool {
        return current == .night
    }
}
