//
//  AlertUtil.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/31.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

/**
 * 弹框工具类
 */

class AlertUtil {
    
    /// 弹出仅带确认键和指定信息的对话框
    func show(controller: UIViewController, msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "确认", style: .default, handler: nil)
        alert.addAction(btnOK)
        controller.present(alert, animated: true, completion: nil)
    }
}
