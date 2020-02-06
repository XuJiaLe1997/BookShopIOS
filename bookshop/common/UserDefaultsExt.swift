//
//  UserDefaultsExt.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/11.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation

protocol UserDefaultsSettable {
    associatedtype key: RawRepresentable
}

extension UserDefaultsSettable where key.RawValue == String {
    
    static func set(value: Any?, forKey key: key) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    
    static func string(forKey key: key) -> String? {
        let aKey = key.rawValue
        return UserDefaults.standard.string(forKey: aKey)
    }
    
    static func bool(forKey key: key) -> Bool? {
        let aKey = key.rawValue
        return UserDefaults.standard.bool(forKey: aKey)
    }
    
    static func integer(forKey key: key) -> Int? {
        let aKey = key.rawValue
        return UserDefaults.standard.integer(forKey: aKey)
    }
    
    static func object(forKey key: key) -> Any? {
        let aKey = key.rawValue
        return UserDefaults.standard.object(forKey: aKey)
    }
    
    static func array(forKey key: key) -> [Any]? {
        let aKey = key.rawValue
        return UserDefaults.standard.array(forKey: aKey)
    }
}

extension UserDefaults {
    
    // 曾使用账号信息
    struct AccountInfo: UserDefaultsSettable{
        enum key: String {
            case userList
        }
    }
    
    // 登录信息
    struct LoginInfo: UserDefaultsSettable {
        enum key: String {
            case token
            case user
        }
    }
    
    // 系统设置信息
    struct AppInfo: UserDefaultsSettable {
        enum key: String {
            case themeStyle
        }
    }
    
    
}
