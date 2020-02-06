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
    private var parentVC: UIViewController?
    
    lazy var imgSet: [UIImage] = [
        UIImage(named: "gundong1")!,
        UIImage(named: "gundong2")!,
        UIImage(named: "gundong3")!,
        UIImage(named: "gundong4")!,
        UIImage(named: "gundong5")!
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.frame.size.width = SCREEN_WIDTH
        backgroundColor = .clear
        
        cycleView = CycleScrollView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH / 2), delegate: self)
        cycleView.rollingEnable = true
        self.addSubview(cycleView)
        
    }
    
    func initCell(parentVC: UIViewController){
        self.parentVC = parentVC
    }
    
    /// MARK: 图片轮播器
    
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

