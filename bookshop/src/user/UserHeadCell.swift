//
//  UserHeadCell.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/10.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

class UserHeadCell: UITableViewCell {
    
    @IBOutlet weak var nicknameTextView: UITextView!
    @IBOutlet weak var descTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.theme_backgroundColor = ThemeColorPicker(keyPath: "Global.barTintColor")
        
        nicknameTextView.theme_textColor = ThemeColorPicker(keyPath: "userHeadCell.textColor")
        nicknameTextView.theme_backgroundColor = ThemeColorPicker(keyPath: "Global.barTintColor")
        
        descTextView.theme_textColor = ThemeColorPicker(keyPath: "userHeadCell.textColor")
        descTextView.theme_backgroundColor = ThemeColorPicker(keyPath: "Global.barTintColor")
    }
}
