//
//  NightSwithCell.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/10.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

class NightSwithCell: BaseCell {
    
    @IBOutlet weak var nightSwitch: UISwitch!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.theme_textColor = ThemeColorPicker(keyPath: "Global.textColor")
        
        nightSwitch.addTarget(self, action: #selector(changeTheme(_:)), for: .valueChanged)
        nightSwitch.isOn = MyThemes.isNight()
    }
    
    @objc func changeTheme(_ sender: UISwitch){
        if(sender.isOn) {
            CBToast.showToastAction(message: "切换深色主题")
        } else {
            CBToast.showToastAction(message: "切换浅色主题")
        }
        MyThemes.switchNight(sender.isOn)
    }
}
