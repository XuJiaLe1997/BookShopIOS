//
//  User.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/17.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding{
    
    var nickname: String?   // 昵称
    var account: String?    // 账号
    var password: String?   // 密码
    
    override init() {
        super.init()
    }
    
    init(account: String, password: String){
        self.nickname = account // 初始化的时候用账号作为昵称
        self.account = account
        self.password = password
    }
    
    func setNickname(nickname: String){
        self.nickname = nickname
    }
    
    // 数据保存到文件夹
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let userSaveDir = DocumentsDirectory.appendingPathComponent("user")
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nickname,forKey: "nicknameKey" )
        aCoder.encode(account,forKey: "accountKey" )
        aCoder.encode(password, forKey: "passwordKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        nickname = aDecoder.decodeObject(forKey: "nicknameKey") as? String
        account = aDecoder.decodeObject(forKey: "accountKey") as? String
        password = aDecoder.decodeObject(forKey: "passwordKey") as? String
    }
}
