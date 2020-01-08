//
//  RegisterController.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/18.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class RegisterController: UIViewController{
    
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var psd2TF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 圆角样式
        joinBtn.layer.cornerRadius = joinBtn.frame.height/2
        // 背景图
        let background = UIImageView(image: UIImage(named: "welcome"))
        let w = self.view.frame.width
        let h = self.view.frame.width * 29 / 41
        background.frame = CGRect(x: 0, y: self.view.frame.height - h, width: w, height: h)
        self.view.addSubview(background)
        
        passwordTextField.isSecureTextEntry = true
        psd2TF.isSecureTextEntry = true
    }
    
    @IBAction func register(_ sender: Any) {
        let var1: String? = accountTextField.text
        let var2: String? = passwordTextField.text
        let var3: String? = psd2TF.text
        var msg = "输入不完整"
        
        if(!StringUtil.isEmpty(str: var1) || !StringUtil.isEmpty(str: var2) || !StringUtil.isEmpty(str: var3)){
            if(var2 != var3) {
                msg = "两次输入的密码不相同"
            } else {
                let res: CommonUtil.Response = CommonUtil.register(account: var1!, password: var2!)
                if(res.isSuccess){
                    self.dismiss(animated: true, completion: nil)
                    return
                } else {
                    msg = res.msg!
                }
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
