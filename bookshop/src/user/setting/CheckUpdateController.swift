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
    
    
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var quitBtn: UIButton!
    @IBOutlet weak var copyright: UILabel!
    @IBOutlet weak var version: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkBtn.layer.cornerRadius = 5
        version.text = "v " + Config.version
        if(Config.showAuthor){
            copyright.text = "Copyright © 2019 - 2020 " + Config.authorName
        }
    }
    
    @IBAction func checkUpdate(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "已更新至最新版本", preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "确认", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func quit(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
}
