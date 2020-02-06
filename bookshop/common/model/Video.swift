//
//  Video.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/4.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

class Video {
    // 标题
    var title: String?
    // 网络地址
    var url: String?
    // 描述
    var desc: String?
    // 作者
    var owner: User?
    // 发布时间
    var date: String?
    // 视频大小（单位：兆）
    var size: Double?
    // 封面
    var cover: UIImage?
    // 点赞数
    var num1: Int = 99
    // 评论数
    var num2: Int = 99
    
    init(title: String, url: String, desc: String = "视频主太懒了，还没添加介绍...") {
        self.title = title
        self.url = url
        self.desc = desc
    }
    
    func getCover() -> UIImage {
        return (cover != nil) ? cover! : UIImage(named: "video")!;
    }
    
    func getOwner() -> User {
        if(owner == nil) {
            owner = User()
            owner?.img = UIImage(named: "img_4")
            owner?.nickname = "匿名用户"
        }
        
        return owner!
    }
    
    func getDateStr() -> String {
        return "2019-07-11 15:23"
    }
}
