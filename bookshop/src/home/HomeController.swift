//
//  HomeController.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/18.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class HomeController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.register(HomeFunctionCell.classForCoder(), forCellReuseIdentifier: "homeFunctionCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return CommonUtil.getBookList().count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 15
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            let functionCell = tableView.dequeueReusableCell(withIdentifier: "homeFunctionCell") as! HomeFunctionCell
            functionCell.controller = self
            return functionCell
        } else if(indexPath.section == 1) {
            let newsCell = tableView.dequeueReusableCell(withIdentifier: "homeNewsCell") as! HomeNewsCell
            newsCell.initCycleView(parentVC: self)
            return newsCell
        } else {
            let bookCell = tableView.dequeueReusableCell(withIdentifier: "homeBookCell", for: indexPath) as! HomeBookCell

            let book: Book = CommonUtil.getBookList()[indexPath.row]
            bookCell.nameLabel.text = book.name
            bookCell.descTextView.text = book.desc
            bookCell.descTextView.isUserInteractionEnabled = false
            bookCell.coverImageView.image = book.cover
            return bookCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return CGFloat(100)
        case 1:
            return CGFloat(200)
        case 2:
            return CGFloat(100)
        default:
            return CGFloat(0)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookDetail"{
            let destination: BookDetailController = segue.destination as! BookDetailController
            if let selectedCell = sender as? UITableViewCell{
                let indexPath = tableView.indexPath(for:selectedCell)!
                let selectedBook = CommonUtil.getBookList()[(indexPath as NSIndexPath).row]
                destination.book = selectedBook
            }
        }
    }
}
