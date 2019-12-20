//
//  LoginController.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/18.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    @IBAction func login(_ sender: Any) {
        let var1: String? = accountTextField.text
        let var2: String? = passwordTextField.text
        var msg = "输入不完整"
        
        if(var1 != nil && var2 != nil && var1!.count > 0 && var2!.count > 0){
            let res: CommonUtil.Response = CommonUtil.login(account: var1!, password: var2!)
            if(res.isSuccess){
                print("登录成功")
                // 登录成功，发送loginSuccess通知，退出本页面
                NotificationCenter.default.post(name: NSNotification.Name("loginSuccess"), object: nil)
                self.dismiss(animated: true, completion: nil)
                return
            } else {
                msg = res.msg!
            }
        }
        
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "确认", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
