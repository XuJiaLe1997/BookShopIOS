//
//  ImageCell.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/11.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

class PlaybillCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let playbill = UIImageView(image: UIImage(named: "video_playbill"))
        playbill.frame = self.frame
        self.addSubview(playbill)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
