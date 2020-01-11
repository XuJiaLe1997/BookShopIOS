//
//  FoundCell.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/4.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

class CircleCell: UICollectionViewCell {
    
    var video: Video!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func initCell(){
        
        let owner = video.getOwner()
        
        // 作者头像
        let head = UIImageView()
        head.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        head.layer.masksToBounds = true
        head.layer.cornerRadius = head.frame.width / 2
        head.contentMode = .scaleToFill
        head.image = owner.getImg()
        self.addSubview(head)
        
        // 作者昵称
        let ownerLabel = UILabel()
        ownerLabel.text = owner.nickname
        ownerLabel.font = UIFont.systemFont(ofSize: 16)
        ownerLabel.frame = CGRect(x: 30, y: 5, width: self.frame.width - 30, height: 20)
        self.addSubview(ownerLabel)
        
        // 发布时间
        let dateLabel = UILabel()
        dateLabel.text = video.getDateStr()
        dateLabel.font = UIFont.systemFont(ofSize: 10)
        dateLabel.frame = CGRect(x: 5, y: head.frame.maxY + 5, width: self.frame.width - 5, height: 20)
        dateLabel.textColor = UIColor.lightGray
        self.addSubview(dateLabel)
        
        // 封面
        let coverImg = UIImageView(image: video.getCover())
        coverImg.frame = CGRect(x: 0, y: dateLabel.frame.maxY + 10, width: self.frame.width, height: self.frame.width*3/5)
        self.addSubview(coverImg)
        
        // 标题
        let title = MultilineLabel(x: 5, y: coverImg.frame.maxY + 10, width: self.frame.width - 10, fontOfSize: 14, textStr: video.title!, lineSpacing: 5)
        self.addSubview(title)
        
        // 摘要
//        let desc = MultilineLabel(x: 5, y: title.frame.maxY + 10, width: self.frame.width - 10, fontOfSize: 12, textStr: video.desc!, lineSpacing: 5)
//        desc.textColor = UIColor.darkGray
//        self.addSubview(desc)
        
        // 点赞
        let icon1 = UIImageView(image: UIImage(named: "dianzan"))
        icon1.frame = CGRect(x: 10, y: title.frame.maxY + 13, width: 15, height: 13)
        self.addSubview(icon1)
        
        let label1 = UILabel(frame: CGRect(x: 30, y: title.frame.maxY + 13 , width: 25, height: 13))
        if(video.num1 >= 99) {
            label1.text = "99+"
        } else {
            label1.text = video.num1.description
        }
        label1.textColor = UIColor.darkGray
        label1.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(label1)
        
        // 评论
        let icon2 = UIImageView(image: UIImage(named: "pinglun"))
        icon2.frame = CGRect(x: 60, y: title.frame.maxY + 10, width: 15, height: 18)
        self.addSubview(icon2)
        
        let label2 = UILabel(frame: CGRect(x: 80, y: title.frame.maxY + 13 , width: 25, height: 13))
        if(video.num2 >= 99) {
            label2.text = "99+"
        } else {
            label2.text = video.num2.description
        }
        label2.textColor = UIColor.darkGray
        label2.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(label2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
