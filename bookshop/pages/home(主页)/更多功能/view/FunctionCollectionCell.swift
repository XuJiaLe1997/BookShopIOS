//
//  FunctionCollectionCell.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/28.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

/**
 * 功能Cell的公共父类
 */

class FunctionCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    // 由子类覆盖提供图标
    func getIconImg() -> UIImage? {
        return nil
    }
    
    // 由子类覆盖提供标题
    func getTitle() -> String? {
        return nil
    }
    
    func initView() {
        let icon = UIImageView(image: getIconImg())
        icon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        icon.center = CGPoint(x: self.bounds.width / 2,
                              y: self.bounds.height / 2 - 10)
        self.addSubview(icon)
        
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 12)
        title.text = getTitle()
        title.textColor = UIColor.darkGray
        title.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        title.textAlignment = NSTextAlignment.center
        title.center = CGPoint(x: self.bounds.width / 2,
                               y: self.bounds.height / 2 + 20)
        self.addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

