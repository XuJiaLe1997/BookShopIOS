//
//  Book.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/18.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class Book: NSObject, NSCoding {
    
    var id: Int?        // ID
    var name: String?   // 书名
    var desc: String?   // 简介
    var price: Double?  // 价格
    var quantity: Int?  // 库存数量
    var cover: UIImage? // 封面
    
    init(id: Int, name: String, desc: String, price: Double, quantity: Int, cover: UIImage?) {
        self.id = id
        self.name = name
        self.desc = desc
        self.price = price
        self.quantity = quantity
        self.cover = cover
    }
    
    // 数据保存到文件夹
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let bookSaveDir = DocumentsDirectory.appendingPathComponent("book")
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id,forKey: "idKey" )
        aCoder.encode(name,forKey: "nameKey" )
        aCoder.encode(desc,forKey: "descKey" )
        aCoder.encode(price, forKey: "priceKey")
        aCoder.encode(quantity, forKey: "quantityKey")
        aCoder.encode(cover, forKey: "coverKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "idKey") as? Int
        name = aDecoder.decodeObject(forKey: "nameKey") as? String
        desc = aDecoder.decodeObject(forKey: "descKey") as? String
        price = aDecoder.decodeObject(forKey: "priceKey") as? Double
        quantity = aDecoder.decodeObject(forKey: "quantityKey") as? Int
        cover = aDecoder.decodeObject(forKey: "coverKey") as? UIImage
    }
}
