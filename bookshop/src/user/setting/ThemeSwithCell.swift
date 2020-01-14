//
//  NightSwithCell.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/10.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

class ThemeSwithCell: BaseCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.theme_textColor = ThemeColorPicker(keyPath: "Global.textColor")
    }
    
}
