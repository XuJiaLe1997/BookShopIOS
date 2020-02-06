//
//  CheckUpdateController.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/18.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class CheckUpdateController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bounds = UIScreen.main.bounds
        
        let img = UIImageView(image: UIImage(named: "img_1"))
        let w = bounds.width - 100 > 300 ? 300 : bounds.width - 100
        img.frame = CGRect(x: (bounds.width - w)/2, y: 50, width: w, height: w)
        view.addSubview(img)
        
        // 版本
        let version = UILabel(frame: CGRect(x: 0, y: img.frame.maxY + 10, width: bounds.width, height: 50))
        version.text = "v " + Config.version
        version.textAlignment = NSTextAlignment.center
        view.addSubview(version)
        
        // 版权声明
        let copyright = UILabel(frame: CGRect(x: 0, y: bounds.height - 80, width: bounds.width, height: 50))
        copyright.textAlignment = NSTextAlignment.center
        copyright.font = .systemFont(ofSize: 13)
        if(Config.showAuthor){
            copyright.text = "Copyright © 2019 - 2020 " + Config.authorName
        } else {
            copyright.text = "Copyright © 2019 - 2020 "
        }
        view.addSubview(copyright)
        
        // 检查更新
        let w2 = bounds.width < 350 ? bounds.width - 100 : 300
        let checkBtn = UIButton(frame: CGRect(x: (bounds.width - w2)/2 , y: copyright.frame.minY - 150, width: w2, height: 40))
        checkBtn.layer.cornerRadius = 5
        checkBtn.backgroundColor = ColorUtil.blue
        checkBtn.setTitle("检查更新", for: .normal)
        checkBtn.addTarget(self, action: #selector(checkUpdate), for: .touchUpInside)
        view.addSubview(checkBtn)
        
        // 退出更新
        let backBtn = UIButton(frame: CGRect(x: bounds.width/2 - 100 , y: checkBtn.frame.maxY, width: 200, height: 50))
        backBtn.setTitle("退出更新", for: .normal)
        backBtn.setTitleColor(.gray, for: .normal)
        backBtn.titleLabel?.font = .systemFont(ofSize: 15)
        backBtn.addTarget(self, action: #selector(quit), for: .touchUpInside)
        view.addSubview(backBtn)
        
    }
    
    @objc func checkUpdate() {
        let alert = UIAlertController(title: nil, message: "已更新至最新版本", preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "确认", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func quit() {
        self.dismiss(animated: true, completion:nil)
    }
}
