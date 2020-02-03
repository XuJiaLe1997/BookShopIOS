//
//  BookInfoCell.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/19.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class BookDescCell: UITableViewCell {
        
    fileprivate var descLabel: MultilineLabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        selectionStyle = .none
    }
    
    
    func setCell(book: Book) {
        if (descLabel != nil) {
            descLabel.removeFromSuperview()
        }
        descLabel = MultilineLabel(x: 10, y: 10, width: SCREEN_WIDTH - 20, fontOfSize: 15, textStr: book.desc!, lineSpacing: 10)
        addSubview(descLabel)
    }
    
    static func getCellWidth(text: String) -> CGFloat {
        return MultilineLabel.caculateHeight(width: SCREEN_WIDTH - 20, fontOfSize: 15, textStr: text, lineSpacing: 10) + 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
