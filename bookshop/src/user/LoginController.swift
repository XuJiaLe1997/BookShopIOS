//
//  LoginController.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/18.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController, DropBoxDelegate {
    
    var accountTextField: EWTextField!
    var passwordTextField: EWTextField!
    var loginBtn: UIButton!
    var phoneLoginBtn: UIButton!
    var forgetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(scrollView)
        
        let xOffset = CGFloat(25)
        let yOffset = CGFloat(50)
        
        accountTextField = EWTextField(frame: CGRect(x: xOffset, y: yOffset,
                                                     width: self.view.frame.width - 2 * xOffset, height: 40), isSecure: false)
        accountTextField.setTitle("账号", ofSize: 18)
        accountTextField.clearButtonMode = .always
        let dropBoxTextField = DropBoxTextField(textField: accountTextField, delegate: self)
        scrollView.addSubview(dropBoxTextField)
        
        passwordTextField = EWTextField(frame: CGRect(x: xOffset, y: accountTextField.frame.maxY + 100,
                                                      width: self.view.frame.width - 2 * xOffset, height: 40), isSecure: true)
        passwordTextField.setTitle("密码", ofSize: 18)
        scrollView.addSubview(passwordTextField)
        
        loginBtn = UIButton(frame: CGRect(x: 10, y: passwordTextField.frame.maxY + 50, width: self.view.frame.width - 20, height: 50))
        loginBtn.backgroundColor = ColorUtil.blue
        loginBtn.layer.cornerRadius = 25
        loginBtn.setTitle("确认登录", for: .normal)
        loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        scrollView.addSubview(loginBtn)
        
        phoneLoginBtn = UIButton(frame: CGRect(x: self.view.frame.width/2 - 100, y: loginBtn.frame.maxY + 5, width: 100, height: 50))
        phoneLoginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        phoneLoginBtn.setTitle("手机快捷登录", for: .normal)
        phoneLoginBtn.setTitleColor(UIColor.darkGray, for: .normal)
        scrollView.addSubview(phoneLoginBtn)
        
        let v = UIView(frame: CGRect(x: self.view.frame.width/2, y: loginBtn.frame.maxY + 20, width: 1, height: 20))
        v.backgroundColor = UIColor.darkGray
        scrollView.addSubview(v)
        
        forgetBtn = UIButton(frame: CGRect(x: self.view.frame.width/2, y: loginBtn.frame.maxY + 5, width: 80, height: 50))
        forgetBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        forgetBtn.setTitle("忘记密码", for: .normal)
        forgetBtn.setTitleColor(UIColor.darkGray, for: .normal)
        scrollView.addSubview(forgetBtn)
        
        scrollView.bringSubviewToFront(dropBoxTextField)
    }
    
    @objc func login() {
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
    
    func count() -> Int {
        return CommonUtil.getAccountList().count
    }
    
    func setItem(_ forItem: Int) -> [String : Any?] {
        let item = CommonUtil.getAccountList()[forItem]
        var img = item.img
        if(img == nil) {
            img = UIImage(named: "user_head_2")
        }
        return ["text": item.account, "img":img]
    }
    
    func didSelectItemAt(_ forItem: Int) {
        accountTextField.placeholderUp()
        accountTextField.bottomLine.isHidden = false
        accountTextField.text = CommonUtil.getAccountList()[forItem].account
    }
    
    func heightForItem(_ forItem: Int) -> CGFloat {
        return 40
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
