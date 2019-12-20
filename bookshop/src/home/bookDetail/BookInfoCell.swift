//
//  BookInfoCell.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/19.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class BookInfoCell: UITableViewCell {
    
    fileprivate var coverImg: UIImageView = UIImageView()
    fileprivate var nameLabel: UILabel = UILabel()
    fileprivate var descLabel: MultilineLabel!
    
    static let offset1: CGFloat = 5
    static let offset2: CGFloat = 40
    static let offset3: CGFloat = 10
    
    func initCell(book: Book, width: CGFloat) {
        
        self.selectionStyle = .none
        
        // 尝试通过代码而不是故事板来设计Cell样式
        coverImg.image = book.cover
        coverImg.frame = CGRect(x: 0, y: 0, width: width, height: width)
        self.addSubview(coverImg)
        
        nameLabel.text = book.name
        nameLabel.frame = CGRect(x: 0, y: width + BookInfoCell.offset1, width: width, height: 20)
        self.addSubview(nameLabel)
        
        descLabel = MultilineLabel(x: 0, y: width + BookInfoCell.offset2, width: width, fontOfSize: 12, textStr: book.desc!, lineSpacing: 10)
        descLabel.frame = CGRect(x: 0, y: width + BookInfoCell.offset2, width: width, height: descLabel.getHeight())
        self.addSubview(descLabel)
    }
    
    // 根据desc文本的长度计算cell高度
    static func getHeightByDesc(width: CGFloat, desc: String) ->  CGFloat {
        let descHeight = MultilineLabel.caculateHeight(width: width, fontOfSize: 12, textStr: desc, lineSpacing: 10)
        return  width + offset2 + descHeight + offset3
    }
    
}
