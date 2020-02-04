//
//  BookDetailController.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/19.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class BookDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var book: Book?
    var comments: [String] = []
    var tableView: UITableView!
    
    fileprivate var addShoppingCarBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        
        let backBtn = UIBarButtonItem(image: ImageUtil.resize(image: UIImage(named: "back")!, size: CGSize(width: 20, height: 20)),
                                      style: .plain, target: self, action: #selector(back))
        navigationItem.setLeftBarButton(backBtn, animated: true)
        
        addShoppingCarBtn = UIBarButtonItem(title: "加入购物车", style: .plain, target: self, action: #selector(addShoppingCar))
        navigationItem.setRightBarButton(addShoppingCarBtn, animated: true)
        
        setNavBarBackgroundColor(color: .white)
        
        tableView.register(BookInfoCell.classForCoder(), forCellReuseIdentifier: "bookInfoCell")
        tableView.register(BookDescCell.classForCoder(), forCellReuseIdentifier: "bookDescCell")
        tableView.register(BookCommentCell.classForCoder(), forCellReuseIdentifier: "bookCommentCell")
        
        for b in CommonUtil.getShoppingCar() {
            if(b.id == book?.id) {
                addShoppingCarBtn.isEnabled = false
                addShoppingCarBtn.title = "已加入购物车"
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : (comments.count == 0 ? 1 : comments.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            if (indexPath.row == 0) {
                let bookInfoCell = tableView.dequeueReusableCell(withIdentifier: "bookInfoCell", for: indexPath) as! BookInfoCell
                bookInfoCell.setCell(model: book!)
                return bookInfoCell
            } else {
                let bookDescCell = tableView.dequeueReusableCell(withIdentifier: "bookDescCell", for: indexPath) as! BookDescCell
                bookDescCell.setCell(book: book!)
                return bookDescCell
            }
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "bookCommentCell", for: indexPath)
        }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                return BookInfoCell.CELL_HEIGHT
            } else {
                return BookDescCell.getCellWidth(text: book!.desc!)
            }
        } else {
            return BookCommentCell.CELL_HEIGHT
        }
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 50
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 1) {
            let v = UIView()
            v.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50)
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.text = "书友评论"
            label.frame = CGRect(x: 10, y: 10, width: 100, height: 30)
            v.addSubview(label)
            return v
        }
        return nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxAlphaOffset = CGFloat(30)
        let minAlphaOffset = -(STATUS_BAR_HEIGHT + (navigationController?.navigationBar.frame.height)!)
        let offset = scrollView.contentOffset.y
        // 按比例计算alpha，且取值在 [0,1]
        let a = max(min((offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset), 1), 0)
        setNavBarBackgroundColorAlpha(alpha: a)
        navigationController?.navigationBar.tintColor = ColorUtil.use255Color(red: (1 - a) * 255, green: (1 - a) * 255, blue: (1 - a) * 255, alpha: 1)
    }
    
    @objc func addShoppingCar() {
        if(CommonUtil.getUser() == nil) {
            let alert = UIAlertController(title: nil, message: "请先登录", preferredStyle: UIAlertController.Style.alert)
            let btnOK = UIAlertAction(title: "确认", style: .default, handler: nil)
            alert.addAction(btnOK)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
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
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
}
