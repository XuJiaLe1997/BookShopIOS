//
//  SearchController.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/28.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class SearchController: UITableViewController, UISearchResultsUpdating{
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // 搜索结果
    var resultList: [Book] = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        // 需要实现UISearchResultsUpdating
        searchController.searchResultsUpdater = self
        
        // 搜索栏样式
        searchController.dimsBackgroundDuringPresentation = false   // 编辑过程模糊化页面
        searchController.searchBar.barTintColor = UIColor.white     // 底部背景白色
        searchController.searchBar.backgroundImage = UIImage()
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar      // 添加searchbar到tableview
        
        // 导航栏样式
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // 搜索结果回显
    func updateSearchResults(for searchController: UISearchController) {
        resultList.removeAll()
        let searchText = searchController.searchBar.text!
        for book in CommonUtil.getBookList() {
            if(book.name!.contains(searchText)){
                resultList.append(book)
            }
        }
        
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCell(withIdentifier: "homeBookCell", for: indexPath) as! HomeBookCell
        let book: Book = resultList[indexPath.row]
        bookCell.nameLabel.text = book.name
        bookCell.descTextView.text = book.desc
        bookCell.descTextView.isUserInteractionEnabled = false
        bookCell.coverImageView.image = book.cover
        return bookCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookDetail2"{
            let destination: BookDetailController = segue.destination as! BookDetailController
            if let selectedCell = sender as? UITableViewCell{
                let indexPath = tableView.indexPath(for:selectedCell)!
                let selectedBook = resultList[(indexPath as NSIndexPath).row]
                destination.book = selectedBook
            }
        }
    }
    
}
