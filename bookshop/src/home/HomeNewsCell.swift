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
    
    let imgSet: [UIImage] = [
        UIImage(named: "gundong1")!,
        UIImage(named: "gundong2")!,
        UIImage(named: "gundong3")!,
        UIImage(named: "gundong4")!,
        UIImage(named: "gundong5")!
    ]
    
    func initCycleView(){
        print("初始化图片轮播器")
        cycleView = CycleScrollView(frame: CGRect.init(x: 0, y: 50, width: self.frame.width, height: 150), delegate: self)
        cycleView.rollingEnable = true
        self.addSubview(cycleView)
    }
    
    func cycleImageCount() -> Int {
        return imgSet.count
    }
    
    func cycleImageView(_ imageView: UIImageView, index: Int) {
        imageView.image = imgSet[index]
    }
    
    func cycleImageViewClick(_ index: Int) {
        print("点击了图片" + String(index))
    }
}

