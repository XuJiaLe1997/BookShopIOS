//
//  BookInfo2Cell.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/20.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class BookInfoCell: UITableViewCell {
    
    static let CELL_HEIGHT = CGFloat(240)
    
    fileprivate var coverImg: UIImageView = UIImageView()
    fileprivate var nameLabel: UILabel = UILabel()
    fileprivate var priceLabel: UILabel = UILabel()
    fileprivate var quantityLabel: UILabel = UILabel()
    fileprivate var scoreLable: UILabel = UILabel()
    
    fileprivate var label1: UILabel = UILabel()
    fileprivate var label2: UILabel = UILabel()
    fileprivate var label3: UILabel = UILabel()
    
    fileprivate var effectView: UIVisualEffectView!
    fileprivate var backgroundImage: UIImageView = UIImageView()
    fileprivate var whiteView: UIView = UIView()
    fileprivate var separatorLine: UIView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        backgroundView = UIView()
        backgroundView?.addSubview(backgroundImage)
        backgroundView?.addSubview(effectView)
        backgroundView?.addSubview(whiteView)
        addSubview(coverImg)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(quantityLabel)
        addSubview(scoreLable)
        addSubview(separatorLine)
        addSubview(label1)
        addSubview(label2)
        addSubview(label3)
    }
    
    override func layoutSubviews() {
        selectionStyle = .none
        
        effectView.frame = frame
        
        coverImg.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        
        nameLabel.frame = CGRect(x: 120, y: 20, width: frame.width - 120, height: 30)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        priceLabel.frame = CGRect(x: 0, y: 150, width: frame.width/3, height: 30)
        priceLabel.font = UIFont.boldSystemFont(ofSize: 25)
        priceLabel.textColor = .red
        priceLabel.textAlignment = .center
        
        label1.frame = CGRect(x: 0, y: 180, width: frame.width/3, height: 30)
        label1.font = UIFont.systemFont(ofSize: 15)
        label1.textAlignment = .center
        label1.textColor = .gray
        label1.text = "价格"
        
        quantityLabel.frame = CGRect(x: frame.width/3, y: 150, width: frame.width/3, height: 30)
        quantityLabel.font = UIFont.boldSystemFont(ofSize: 25)
        quantityLabel.textAlignment = .center
        
        label2.frame = CGRect(x: frame.width/3, y: 180, width: frame.width/3, height: 30)
        label2.font = UIFont.systemFont(ofSize: 15)
        label2.textAlignment = .center
        label2.textColor = .gray
        label2.text = "库存"
        
        scoreLable.frame = CGRect(x: frame.width*2/3, y: 150, width: frame.width/3, height: 30)
        scoreLable.font = UIFont.boldSystemFont(ofSize: 25)
        scoreLable.textAlignment = .center
        scoreLable.text = "5"
        
        label3.frame = CGRect(x: frame.width*2/3, y: 180, width: frame.width/3, height: 30)
        label3.font = UIFont.systemFont(ofSize: 15)
        label3.textAlignment = .center
        label3.textColor = .gray
        label3.text = "评分"
        
        separatorLine.frame = CGRect(x: 20, y: frame.height - 5, width: frame.width - 40, height: 0.7)
        separatorLine.backgroundColor = ColorUtil.use255Color(red: 205, green: 205, blue: 205, alpha: 0.8)
        
        // 用三层view构造一个毛玻璃颜色渐变的视觉效果
        effectView.frame = CGRect(x: 0, y: frame.height - SCREEN_WIDTH - 90, width: SCREEN_WIDTH, height: SCREEN_WIDTH)
        backgroundImage.frame = effectView.frame
        whiteView.frame = effectView.frame
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: whiteView.frame.width, height: whiteView.frame.height)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        whiteView.layer.addSublayer(gradientLayer)
    }
    
    func setCell(model: Book) {
        coverImg.image = model.cover
        backgroundImage.image = model.cover
        nameLabel.text = model.name
        priceLabel.text = model.price?.description
        quantityLabel.text = model.quantity?.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
