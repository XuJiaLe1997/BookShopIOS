//
//  BaseCell.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/10.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UITableViewCell {
    
    override func awakeFromNib() {
        self.theme_backgroundColor = ThemeColorPicker(keyPath: "Global.backgroundColor")
    }
    
}
