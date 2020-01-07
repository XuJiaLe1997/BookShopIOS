//
//  Address.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/7.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation

class Address: NSObject, NSCoding{
    
    var addr: String?
    var receiver: String?
    var phone: String?
    
    init(addr: String, receiver: String, phone: String) {
        self.addr = addr
        self.receiver = receiver
        self.phone = phone
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(addr, forKey: "addrKey")
        aCoder.encode(receiver, forKey: "recvKey")
        aCoder.encode(phone, forKey: "phoneKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        addr = aDecoder.decodeObject(forKey: "addrKey") as? String
        receiver = aDecoder.decodeObject(forKey: "recvKey") as? String
        phone = aDecoder.decodeObject(forKey: "phoneKey") as? String
    }
}
