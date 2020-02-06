//
//  CategoryCollectionCell.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/28.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class CircleCollectionCell: FunctionCollectionCell {
    
    override func getTitle() -> String? {
        return "圈子"
    }
    
    override func getIconImg() -> UIImage? {
        return UIImage(named: "earth")
    }
}
