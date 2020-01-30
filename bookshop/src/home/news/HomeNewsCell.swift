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
class HomeNewsCell: UITableViewCell, CycleScrollViewDelegate, VerticalCycleViewDelegate {
    
    var verticalCycleView: VerticalCycleView!
    var cycleView: CycleScrollView!
    private var parentVC: UIViewController?
    
    let imgSet: [UIImage] = [
        UIImage(named: "gundong1")!,
        UIImage(named: "gundong2")!,
        UIImage(named: "gundong3")!,
        UIImage(named: "gundong4")!,
        UIImage(named: "gundong5")!
    ]
    
    var textSet = [
        (text: "重读康有为，体验是非功过", tag: "Hot"),
        (text: "程序员必读的百大经典", tag: "好评"),
        (text: "钟南山院士谈肺炎的一线访谈记录现正火热发售中", tag: "Hot"),
        (text: "二次元精选好书", tag: "精选"),
        (text: "建国70周年，回顾祖国建设的峥嵘岁月", tag: "Hot"),
        (text: "近百册正史、野史资料汇聚，助你走遍上下五千年", tag: "Hot")
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.frame.size.width = UIScreen.main.bounds.width
        
        let title = MultilineLabel(x: 10, y: 5, width: 50, fontOfSize: 16, textStr: "今日\n推荐", lineSpacing: 5)
        title.textColor = .darkGray
        self.addSubview(title)
        
        let v = UIView(frame: CGRect(x: 50, y: 7, width: 2, height: 41))
        v.backgroundColor = .lightGray
        self.addSubview(v)
        
        if(textSet.count != 0) {
            if(textSet.count == 1) {
                textSet.append((text: "", tag: ""))
            }
            verticalCycleView = VerticalCycleView(frame: CGRect(x: 60, y: 0, width: self.frame.width - 60, height: 50), delegate: self)
            verticalCycleView.rollingEnable = textSet.count > 2
            self.addSubview(verticalCycleView)
        }
        
        cycleView = CycleScrollView(frame: CGRect.init(x: 0, y: 50, width: self.frame.width, height: 150), delegate: self)
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
    
    /// MARK: 文字垂直播放器
    
    func cycleItemCount() -> Int {
        return textSet.count
    }
    
    func cycleItemFor(_ index: Int) -> (text: String, tag: String) {
        return textSet[index]
    }
    
    func cycleItemClick(_ index: Int) {
    }
    
}

