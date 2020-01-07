//
//  AddressCell.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/6.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

// 通过代理与控制器交互
protocol CellEventDelegate {
    func onclick(index: Int)
}

let width = UIScreen.main.bounds.width

class AddressCell: UITableViewCell {
    
    var addr: Address?
    var delegate: CellEventDelegate?
    var index: Int?
    
    var recvLabel: UILabel = UILabel()
    var phoneLabel: UILabel = UILabel()
    var btn: UIButton = UIButton()
    var addrLabel: MultilineLabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        recvLabel.frame = CGRect(x: 15, y: 15, width: width/4, height: 20)
        self.addSubview(recvLabel)
        
        phoneLabel.frame = CGRect(x: recvLabel.frame.maxX + 10, y: 15, width: width/3, height: 20)
        self.addSubview(phoneLabel)
        
        btn.frame = CGRect(x: width - 50, y: 15, width: 20, height: 20)
        btn.setBackgroundImage(UIImage(named: "modify"), for: .normal)
        btn.addTarget(self, action: #selector(onclick), for: .touchUpInside)
        self.addSubview(btn)
        
        addrLabel = MultilineLabel(x: 15, y: recvLabel.frame.maxY + 10, width: width - 90, fontOfSize: 14, textStr: "", lineSpacing: 5)
        self.addSubview(addrLabel!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCell(index: Int, addr: Address, delegate: CellEventDelegate) {
        self.index = index
        self.addr = addr
        self.delegate = delegate
        
        recvLabel.text = addr.receiver
        phoneLabel.text = addr.phone
        addrLabel?.setText(textStr: addr.addr!)
    }
    
    @objc func onclick() {
        delegate?.onclick(index: self.index!)
    }
    
    
}
