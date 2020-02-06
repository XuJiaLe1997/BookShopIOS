//
//  StringUtil.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/7.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation

class StringUtil {
    
    class func isEmpty(str: String?) -> Bool {
        return str == nil || str!.count <= 0
    }
}
