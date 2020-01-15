//
//  HomeNewsCell.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/18.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

// 图片轮播器的Cell，今日消息
class HomeNewsCell: UITableViewCell, CycleScrollViewDelegate {
    
    var cycleView: CycleScrollView!
    var isInit: Bool = false
    private var parentVC: UIViewController?
    
    let imgSet: [UIImage] = [
        UIImage(named: "gundong1")!,
        UIImage(named: "gundong2")!,
        UIImage(named: "gundong3")!,
        UIImage(named: "gundong4")!,
        UIImage(named: "gundong5")!
    ]
    
    func initCycleView(parentVC: UIViewController){
        if(!isInit){    // 防止重复初始化
            print("初始化图片轮播器")
            cycleView = CycleScrollView(frame: CGRect.init(x: 0, y: 50, width: self.frame.width, height: 150), delegate: self)
            cycleView.rollingEnable = true
            self.addSubview(cycleView)
            self.parentVC = parentVC
            isInit = true
        }
    }
    
    func cycleImageCount() -> Int {
        return imgSet.count
    }
    
    func cycleImageView(_ imageView: UIImageView, index: Int) {
        imageView.image = imgSet[index]
    }
    
    func cycleImageViewClick(_ index: Int) {
        var newsPath = CommonUtil.getNewsPath()?[index]
        if(newsPath == nil) {
            newsPath = "/Users/xujiale/XcodeProject/bookshop/bookshop/resources/h5/index.html"
        }
        let news = WebController(path: newsPath!)
        let navController = UINavigationController(rootViewController: news)
        
        parentVC?.present(navController, animated: true, completion: nil)
    }
    
    @objc func back(vc: UIViewController) {
        vc.dismiss(animated: true, completion: nil)
    }
}

