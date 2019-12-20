//
//  UserViewController.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/17.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class UserController: UITableViewController {
    
    @IBOutlet weak var nicknameTextView: UITextView!
    @IBOutlet weak var headImage: UIImageView!
    
    // 界面初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        headImage.layer.masksToBounds = true
        headImage.layer.cornerRadius = headImage.frame.width / 2
        
        // 注册监听器，监听loginSuccess通知
        NotificationCenter.default.addObserver(self, selector: #selector(observerLoginSuccess), name: NSNotification.Name(rawValue:"loginSuccess"), object: nil)
        
        viewDidLoadHelper()
    }
    
    // 界面初始化helper
    func viewDidLoadHelper(){
        if(CommonUtil.getUser() == nil) {
            print("用户未登录")
            nicknameTextView.text = "未登录"
            headImage.image = UIImage(named: "img_4")
        } else {
            nicknameTextView.text = CommonUtil.getUser()?.nickname
        }
    }
    
    // 登录
    @IBAction func login(_ sender: UITapGestureRecognizer) {
        if(CommonUtil.getUser() == nil) {
            print("用户未登录，进入登录页面")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    // 监听登录成功的通知，重新加载页面
    @objc func observerLoginSuccess(){
        print("监听到loginSuccess通知")
        viewDidLoadHelper()
    }
    
    // 退出登录
    @IBAction func quitLogin(_ segue: UIStoryboardSegue){
        print("退出登录")
        CommonUtil.quitLogin()
        viewDidLoadHelper()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    deinit {
        // 取消通知
        NotificationCenter.default.removeObserver(self)
    }
}
