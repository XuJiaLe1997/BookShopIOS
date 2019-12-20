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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        joinBtn.layer.cornerRadius = 5
    }
    
    @IBAction func register(_ sender: Any) {
        let var1: String? = accountTextField.text
        let var2: String? = passwordTextField.text
        var msg = "输入不完整"
        
        if(var1 != nil && var2 != nil && var1!.count > 0 && var2!.count > 0){
            let res: CommonUtil.Response = CommonUtil.register(account: var1!, password: var2!)
            if(res.isSuccess){
                print("注册成功")
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
