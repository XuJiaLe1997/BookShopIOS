//
//  BookDetailController.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/19.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class BookDetailController: UITableViewController {
    
    var book: Book?
    
    @IBOutlet weak var addShoppingCarBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()

        for b in CommonUtil.getShoppingCar() {
            if(b.id == book?.id) {
                addShoppingCarBtn.isEnabled = false
                addShoppingCarBtn.title = "已加入购物车"
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            let bookInfoCell = tableView.dequeueReusableCell(withIdentifier: "bookInfoCell", for: indexPath) as! BookInfoCell
            bookInfoCell.initCell(book: self.book!, width: self.tableView.frame.width)
            return bookInfoCell
        } else {
            let bookInfo2Cell = tableView.dequeueReusableCell(withIdentifier: "bookInfo2Cell", for: indexPath) as! BookInfo2Cell
            bookInfo2Cell.priceLabel.text = book?.price?.description
            bookInfo2Cell.quantityLabel.text = book?.quantity?.description
            return bookInfo2Cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return BookInfoCell.getHeightByDesc(width: self.tableView.frame.width, desc: self.book!.desc!)
        } else {
            return 80
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 15
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addShoppingCar(_ sender: Any) {
        let res = CommonUtil.addShoppingCar(book: book!) as CommonUtil.Response
        if(res.isSuccess) {
            addShoppingCarBtn.isEnabled = false
            addShoppingCarBtn.title = "已加入购物车"
            self.tableView.reloadData()
        } else {
            let alert = UIAlertController(title: nil, message: res.msg, preferredStyle: UIAlertController.Style.alert)
            let btnOK = UIAlertAction(title: "确认", style: .default, handler: nil)
            alert.addAction(btnOK)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
