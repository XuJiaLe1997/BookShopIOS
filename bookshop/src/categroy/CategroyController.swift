//
//  CategroyController.swift
//  bookshop
//
//  Created by Xujiale on 2020/2/2.
//  Copyright © 2020 xujiale. All rights reserved.
//

/*
 * 分类页面
 */

import Foundation
import UIKit

class CategoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var leftTableView: UITableView!
    var rightTableView: UITableView!
    var headerView: TableHeaderView!
    
    var leftTableItems: [String] = []
    var rightTableItems: [Book] = []
    
    // MARK: 数据请求、View实例化
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        leftTableView = UITableView()
        leftTableView.register(CategoryCell.classForCoder(), forCellReuseIdentifier: "categoryCell")
        leftTableView.dataSource = self
        leftTableView.delegate = self
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
        view.addSubview(leftTableView)
        
        rightTableView = UITableView()
        rightTableView.register(BookDetailCell.classForCoder(), forCellReuseIdentifier: "bookDetailCell")
        rightTableView.dataSource = self
        rightTableView.delegate = self
        view.addSubview(rightTableView)
        
        headerView = TableHeaderView()
        rightTableView.tableHeaderView = headerView
    }
    
    /// MARK: 数据请求
    fileprivate func loadData() {
        leftTableItems = ["精选", "都市", "玄幻", "历史", "仙侠", "科幻", "游戏", "职场", "武侠", "奇幻", "灵异", "军事", "短篇"]
        rightTableItems = CommonUtil.getBooksListByCategroy(leftTableItems[0])
    }
    
    /// MARK: View布局
    override func viewDidLayoutSubviews() {
        leftTableView.frame = CGRect(x: 0, y: 0, width: CategoryCell.CELL_WIDTH, height: SCREEN_HEIGHT)
        leftTableView.separatorStyle = .none
        leftTableView.showsVerticalScrollIndicator = false
        leftTableView.showsHorizontalScrollIndicator = false
        leftTableView.tableFooterView = UIView()
        leftTableView.bounces = false
        
        rightTableView.frame = CGRect(x: CategoryCell.CELL_WIDTH, y: 0,
                                      width: SCREEN_WIDTH - CategoryCell.CELL_WIDTH,
                                      height: SCREEN_HEIGHT)
        rightTableView.separatorStyle = .none
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.showsHorizontalScrollIndicator = false
        rightTableView.tableFooterView = UIView()
        
        headerView.frame = CGRect(x: 0, y: 0, width: rightTableView.frame.width, height: 60)
        
        setRightTable()
    }
    
    fileprivate func setRightTable() {
        headerView.countView.text = "共 \(rightTableItems.count) 本"
        headerView.btn.setTitle("排序·默认", for: .normal)
        rightTableView.reloadData()
    }
    
    /// MARK: 表格数据源、样式
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return leftTableItems.count
        } else {
            return rightTableItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
            cell.categoryLabel.text = leftTableItems[indexPath.row]
            return cell
        } else {
            let bookCell = tableView.dequeueReusableCell(withIdentifier: "bookDetailCell", for: indexPath) as! BookDetailCell
            
            let book: Book = rightTableItems[indexPath.row]
            bookCell.titleLabel.text = book.name
            bookCell.coverImageView.image = book.cover
            return bookCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == leftTableView {
            return CategoryCell.CELL_HEIGHT
        } else {
            return BookDetailCell.CELL_HEIGHT
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            // 数据请求并更新
            rightTableItems = CommonUtil.getBooksListByCategroy(leftTableItems[indexPath.row])
            setRightTable()
        } else {
            // TODO 书籍详情页
        }
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
}

/// MARK: 分类条目
class CategoryCell: UITableViewCell {
    
    static let CELL_WIDTH = CGFloat(100)
    static let CELL_HEIGHT = CGFloat(70)
    
    var categoryLabel: UILabel!
    var selectedView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        categoryLabel = UILabel()
        addSubview(categoryLabel)
        
        selectedView = UIView()
        selectedBackgroundView = selectedView
    }
    
    override func layoutSubviews() {
        backgroundColor = ColorUtil.use255Color(red: 245, green: 245, blue: 245, alpha: 0.8)
        
        categoryLabel.frame = CGRect(x: 0, y: 20, width: frame.width - 20, height: 30)
        categoryLabel.textAlignment = .center
        categoryLabel.textColor = .darkGray
        
        selectedView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        selectedView.backgroundColor = .white
        let selectedSubView = UIView(frame: CGRect(x: 0, y: 20, width: 6, height: 30))
        selectedSubView.layer.cornerRadius = 3
        selectedSubView.theme_backgroundColor = ThemeColorPicker(keyPath: "Global.barTintColor")
        selectedView.addSubview(selectedSubView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/// MARK: 书籍详情
class BookDetailCell: UITableViewCell {
    
    static let CELL_HEIGHT = CGFloat(100)
    
    var titleLabel: UILabel!
    var coverImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel()
        addSubview(titleLabel)
        
        coverImageView = UIImageView()
        addSubview(coverImageView)
    }
    
    override func layoutSubviews() {
        titleLabel.frame = CGRect(x: 100, y: 20, width: frame.width - 100, height: 40)
        coverImageView.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/// MARK: 右表格头部
class TableHeaderView: UIView {
    
    static let HEADER_HEIGHT = 60
    
    var countView: UILabel!
    var btn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        countView = UILabel()
        btn = UIButton()
        
        addSubview(countView)
        addSubview(btn)
    }
    
    override func layoutSubviews() {
        countView.frame = CGRect(x: 10, y: 15, width: 100, height: 30)
        countView.textColor = .darkGray
        btn.frame = CGRect(x: frame.width - 120, y: 15, width: 100, height: 30)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.cornerRadius = 15
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
