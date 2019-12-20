//
//  CommonUtil.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/17.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class CommonUtil {
    
    // 执行结果类
    class Response: NSObject {
        var isSuccess: Bool = false;    // 执行结果
        var msg: String?;               // 描述信息
        
        override init(){
            super.init();
        }
        
        init(isSuccess : Bool, msg: String){
            self.isSuccess = isSuccess;
            self.msg = msg;
        }
    }
    
    /* ======= 用户接口 begin ====== */
    
    private static var curUser: User?
    private static var userList: [User] = [User]()
    
    static func login(account: String, password: String) -> Response {
        for u in userList {
            if(u.account == account){
                if(u.password == password){
                    curUser = u
                    return Response(isSuccess: true, msg: "登录成功")
                } else {
                    return Response(isSuccess: false, msg: "密码错误")
                }
            }
        }
        return Response(isSuccess: false, msg: "账号不存在");
    }
    
    static func register(account: String, password: String) -> Response {
        for u in userList {
            if(u.account == account) {
                return Response(isSuccess: false, msg: "账号已存在")
            }
        }
        
        addUser(u: User(account: account, password: password))
        return Response(isSuccess: true, msg: "注册成功");
    }
    
    static func addUser(u: User!) {
        userList.append(u)
        NSKeyedArchiver.archiveRootObject(userList, toFile: User.userSaveDir.path)
    }
    
    static func getUser() -> User? {
        return curUser
    }
    
    static func quitLogin() {
        curUser = nil
    }
    
    /* ======= end ======== */
    
    /* ======= 书库接口 begin ====== */
    
    private static var bookList: [Book] = [Book]()
    
    static func getBookList() -> ([Book]){
        return bookList
    }
    
    static func saveBookList() {
        NSKeyedArchiver.archiveRootObject(bookList, toFile: Book.bookSaveDir.path)
    }
    
    /* ======= end ======== */
    
    /* ======= 购物车接口 begin ====== */
    
    private static var shoppingCar: [Book] = [Book]()
    
    static func getShoppingCar() ->[Book] {
        return shoppingCar
    }
    
    // 加入购物车
    static func addShoppingCar(book: Book) -> Response {
        let quantity = book.quantity!
        if(quantity <= 0) {
            return Response(isSuccess: false, msg: "售罄，请联系掌柜")
        }
        book.quantity = quantity - 1    // 库存减1
        shoppingCar.append(book)
        // TODO 持久化保存

        return Response(isSuccess: true, msg: "加入购物车成功")
    }
    
    // 移出购物车
    static func removeFromShoppingCar(book: Book) {
        if let index = shoppingCar.firstIndex(of: book) {
            shoppingCar.remove(at: index)
            book.quantity = book.quantity! + 1  // 重新上架，库存加1
            // TODO 持久化保存
        }
    }
    
    // 清空购物车
    static func clearShoppingCar() {
        // 重新上架
        for b in shoppingCar {
            b.quantity = b.quantity! + 1
        }
        
        // 移除购物车所有条目
        shoppingCar.removeAll()
    }
    
    // 购买
    static func buy() {
        // TODO 计算总数额
        
        // TODO 校验收货信息、支付信息等
        
        // TODO 扣款
        
        // 移除购物车所有条目
        shoppingCar.removeAll()
    }
    
    /* ======= end ======== */
    
    /* ======= 数据初始化 begin ====== */
    
    static func loadBooks(){
        if let defaultBookList =
            (NSKeyedUnarchiver.unarchiveObject(withFile:Book.bookSaveDir.path)as?[Book]){
            print("已从本地加载所有书籍信息")
            bookList = defaultBookList
        } else {
            print("本地无数据，初始化所有书籍信息，并保存在本地")
            bookList.append(Book(id: 1, name: "白夜行", desc: "《白夜行》是日本作家东野圭吾创作的长篇小说，也是其代表作。该小说于1997年1月至1999年1月间连载于期刊，单行本1999年8月在日本发行。故事围绕着一对有着不同寻常情愫的小学生展开。1973年，大阪的一栋废弃建筑内发现了一具男尸，此后19年，嫌疑人之女雪穗与被害者之子桐原亮司走上截然不同的人生道路，一个跻身上流社会，一个却在底层游走，而他们身边的人，却接二连三地离奇死去，警察经过19年的艰苦追踪，终于使真相大白。", price: 19.0, quantity: 1, cover: UIImage(named: "1")!))
            bookList.append(Book(id: 2, name: "简爱", desc: "《简·爱》（Jane Eyre）是英国女作家夏洛蒂·勃朗特创作的长篇小说，是一部具有自传色彩的作品。作品讲述一位从小变成孤儿的英国女子在各种磨难中不断追求自由与尊严，坚持自我，最终获得幸福的故事。小说引人入胜地展示了男女主人公曲折起伏的爱情经历，歌颂了摆脱一切旧习俗和偏见，成功塑造了一个敢于反抗，敢于争取自由和平等地位的妇女形象。", price: 29.0, quantity: 2, cover: UIImage(named: "2")!))
            bookList.append(Book(id: 3, name: "芒果街上的小屋", desc: "《芒果街上的小屋》是美国作家桑德拉·希斯内罗丝（Sandra Cisneros）创作的长篇小说，首次出版于1984年。《芒果街上的小屋》所记录的，是从女孩蜕变为女人的过程，是少女时代的最后一段光阴。作品的触角伸向生活的每个角落，妈妈，婶婶，一朵小云彩，一只小狗，一次小伤心，一点小悸动在少女澄澈的眼底，这些都打上了“家”和“回忆”的记号。", price: 19.0, quantity: 3, cover: UIImage(named: "3")!))
            bookList.append(Book(id: 4, name: "活着", desc: "《活着》是作家余华的代表作之一，讲述了在大时代背景下，随着内战、三反五反，大跃进，文化大革命等社会变革，徐福贵的人生和家庭不断经受着苦难，到了最后所有亲人都先后离他而去，仅剩下年老的他和一头老牛相依为命。余华因这部小说于2004年3月荣获法兰西文学和艺术骑士勋章。", price: 19.0, quantity: 2, cover: UIImage(named: "4")!))
            bookList.append(Book(id: 5, name: "羊脂球", desc: "《羊脂球》是法国作家莫泊桑创作的中篇小说。《羊脂球》是他的成名作，也是他的代表作之一。《羊脂球》以1870—1871年普法战争为背景。通过代表当时法国社会各阶层的10个人同乘一辆马车逃往一个港口的故事，形象地反映出资产阶级在这场战争中所表现出的卑鄙自私和出卖人民的丑恶嘴脸。在小说中，作者把下等人和上等人作了对比，检验了他们的道德水准。羊脂球是一个有爱国心的妓女，10人当中只有羊脂球配得上称为高尚的人和有爱国心的人。她心地善良，在马车上，尽管那些贵族资产阶级老爷太太对她表示了轻视和侮辱，可是当他们饥饿难耐的时候，羊脂球慷慨地请他们分享自己的食物。她还有强烈的民族自尊心。而那些所谓上等人都是些灵魂丑恶、损人利己的败类。", price: 29.0, quantity: 4, cover: UIImage(named: "5")!))
        bookList.append(Book(id: 6, name: "Java编程思想", desc: "《Java编程思想》是2007年机械工业出版社出版的图书，作者是埃克尔，译者是陈昊鹏。", price: 59.0, quantity: 0, cover: UIImage(named: "6")!))
            
            saveBookList()
        }
    }
    
    static func loadUsers(){
        if let defaultUserList =
            (NSKeyedUnarchiver.unarchiveObject(withFile:User.userSaveDir.path)as?[User]){
            print("已从本地加载所有用户信息")
            userList = defaultUserList
        } else {
            print("本地无数据，初始化admin账号")
            addUser(u: User(account: "admin", password: "admin"))
        }
    }
    
    /* ======= end ======== */
    
}
