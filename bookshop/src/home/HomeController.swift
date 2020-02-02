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
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        self.tableView.register(HomeFunctionCell.classForCoder(), forCellReuseIdentifier: "homeFunctionCell")
        self.tableView.register(HomeNewsCell.classForCoder(), forCellReuseIdentifier: "homeNewsCell")
        self.tableView.register(HomeNewsCell2.classForCoder(), forCellReuseIdentifier: "homeNewsCell2")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return CommonUtil.getBookList().count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 3) {
            return 30
        }
        return 0
    }
    
    // Section 间隔设置为白色
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        if (section == 3) {
            let v = UIView(frame: CGRect(x: 0, y: 5, width: 10, height: 20))
            v.backgroundColor = .blue
            headerView.addSubview(v)
            
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: 100, height: 30))
            label.text = "全部书籍"
            label.font = UIFont.systemFont(ofSize: 18)
            headerView.addSubview(label)
            
            let btn = UIButton(frame: CGRect(x: SCREEN_WIDTH - 80, y: 0, width: 80, height: 30))
            btn.setTitle("更多", for: .normal)
            btn.setTitleColor(.lightGray, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            btn.addTarget(self, action: #selector(clickMore), for: .touchUpInside)
            headerView.addSubview(btn)
        }
        return headerView
    }
    
    @objc func clickMore() {
        CBToast.showToastAction(message: "没有更多了")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            let functionCell = tableView.dequeueReusableCell(withIdentifier: "homeFunctionCell") as! HomeFunctionCell
            functionCell.controller = self
            return functionCell
        }
        else if(indexPath.section == 2) {
            let newsCell = tableView.dequeueReusableCell(withIdentifier: "homeNewsCell2") as! HomeNewsCell2
            return newsCell
        } else if (indexPath.section == 1) {
            let newsCell = tableView.dequeueReusableCell(withIdentifier: "homeNewsCell") as! HomeNewsCell
            newsCell.initCell(parentVC: self)
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
        case 2:
            return 50
        case 1:
            return SCREEN_WIDTH / 2
        case 3:
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
