//
//  BookCommentCel.swift
//  bookshop
//
//  Created by Xujiale on 2020/2/3.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

class BookCommentCell: UITableViewCell {
    
    static let CELL_HEIGHT = CGFloat(100)
    
    fileprivate let emptyView: UIView = {
        let v = UIView()
        let label = UILabel()
        label.text = "暂时还没有评论，快来抢沙发吧!"
        label.textColor = UIColor.lightGray
        label.textAlignment = NSTextAlignment.center
        label.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30)
        v.addSubview(label)
        return v
    }()
    
    var comment: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        
        selectionStyle = .none
        
        if (comment == nil) {
            backgroundView = emptyView
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
