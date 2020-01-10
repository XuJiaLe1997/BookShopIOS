//
//  SettingController.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/18.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class SettingController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.theme_backgroundColor = ThemeColorPicker(keyPath: "Global.backgroundColor")
        tableView.theme_separatorColor = ThemeColorPicker(keyPath:"ListViewController.separatorColor")
        
        tableView.tableFooterView = UIView()
    }
}
