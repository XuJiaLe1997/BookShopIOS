//
//  ThemeSwitchController.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/14.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

class ThemeSwitchController: UIViewController {
    
    override func viewDidLoad() {
        
        let w = view.frame.width - 20
        let nH = (navigationController?.navigationBar.frame.height)!
        let tH = (tabBarController?.tabBar.frame.height)!
        let h = ((view.frame.height - nH - tH) - 10 * 6) / 5
        
        
        let redBtn = UIButton(frame: CGRect(x: 10, y: 10, width: w, height: h))
        redBtn.backgroundColor = UIColor(hex6: 0xFF6347)
        redBtn.tag = 0
        redBtn.addTarget(self, action: #selector(change(_:)), for: .touchUpInside)
        redBtn.layer.cornerRadius = 10
        view.addSubview(redBtn)
        
        let darkBtn = UIButton(frame: CGRect(x: 10, y: redBtn.frame.maxY + 10, width: w, height: h))
        darkBtn.backgroundColor = UIColor(hex6: 0x292421)
        darkBtn.tag = 1
        darkBtn.addTarget(self, action: #selector(change(_:)), for: .touchUpInside)
        darkBtn.layer.cornerRadius = 10
        view.addSubview(darkBtn)
        
        let blueBtn = UIButton(frame: CGRect(x: 10, y: darkBtn.frame.maxY + 10, width: w, height: h))
        blueBtn.backgroundColor = UIColor(hex6: 0x3D59AB)
        blueBtn.tag = 2
        blueBtn.addTarget(self, action: #selector(change(_:)), for: .touchUpInside)
        blueBtn.layer.cornerRadius = 10
        view.addSubview(blueBtn)
        
        let greenBtn = UIButton(frame: CGRect(x: 10, y: blueBtn.frame.maxY + 10, width: w, height: h))
        greenBtn.backgroundColor = UIColor(hex6: 0x00C957)
        greenBtn.tag = 3
        greenBtn.addTarget(self, action: #selector(change(_:)), for: .touchUpInside)
        greenBtn.layer.cornerRadius = 10
        view.addSubview(greenBtn)
        
        let yellowBtn = UIButton(frame: CGRect(x: 10, y: greenBtn.frame.maxY + 10, width: w, height: h))
        yellowBtn.backgroundColor = UIColor(hex6: 0xFFD700)
        yellowBtn.tag = 4
        yellowBtn.addTarget(self, action: #selector(change(_:)), for: .touchUpInside)
        yellowBtn.layer.cornerRadius = 10
        view.addSubview(yellowBtn)
    }
    
    @objc func change(_ sender: UIButton?) {
        switch sender?.tag{
        case 1:
            MyThemes.switchTo(.night)
            CBToast.showToastAction(message: "切换深色主题")
        case 2:
            MyThemes.switchTo(.blue)
            CBToast.showToastAction(message: "切换蓝色主题")
        case 3:
            MyThemes.switchTo(.green)
            CBToast.showToastAction(message: "切换绿色主题")
        case 4:
            MyThemes.switchTo(.yellow)
            CBToast.showToastAction(message: "切换黄色主题")
        default:
            MyThemes.switchTo(.red)
            CBToast.showToastAction(message: "切换红色主题")
        }
    }
    
}
