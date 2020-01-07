//
//  LinearTextField.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/7.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

/*
 * 线型的文本输入框
 */

class LinearTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let border = CALayer()
        let borderWidth = CGFloat(2.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: frame.height - borderWidth, width:  frame.width, height: frame.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
