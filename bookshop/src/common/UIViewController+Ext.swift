//
//  UIViewController+Ext.swift
//  bookshop
//
//  Created by Xujiale on 2020/2/4.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

private var navigationBarBackgroundKey = "navigationBarBackgroundKey"

extension UIViewController {
    
    func setNavBarBackgroundColor(color: UIColor) {
        let backgroundView = objc_getAssociatedObject(self, &navigationBarBackgroundKey) as? UIView
        if navigationController != nil && backgroundView == nil {
            // 导航栏设为透明
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
            // 使用一个占位的view模拟导航栏背景
            // 修改此view的背景在视觉上等同于修改导航栏的背景
            let backgroundView = UIView(frame: CGRect(x: 0,
                                                y: STATUS_BAR_HEIGHT + (navigationController?.navigationBar.frame.height)! - view.frame.width,
                                                width: view.frame.width,
                                                height: view.frame.width))
            backgroundView.backgroundColor = color
            backgroundView.isUserInteractionEnabled = false
            backgroundView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            backgroundView.layer.borderWidth = 0.3
            backgroundView.layer.borderColor = UIColor.lightGray.cgColor
            view.addSubview(backgroundView)
            // 保持在最顶层
            view.bringSubviewToFront(backgroundView)
            // extension不能直接添加存储属性
            objc_setAssociatedObject(self, &navigationBarBackgroundKey, backgroundView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // 调用此方法修改导航栏透明度
    func setNavBarBackgroundColorAlpha(alpha:CGFloat) {
        let backGroundView = objc_getAssociatedObject(self, &navigationBarBackgroundKey) as? UIView
        backGroundView?.alpha = alpha
    }
    
}

