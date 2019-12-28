//
//  HomeFunctionCell.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/19.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class HomeFunctionCell: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegate {
    
    let ScreenWidth  = UIScreen.main.bounds.width
    let numberOfFunction = 4
    var controller: UIViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let layout = UICollectionViewFlowLayout.init()
        // 默认平分宽度，固定高100
        layout.itemSize = CGSize(width: self.frame.width/CGFloat(numberOfFunction), height: 100)
        // 行间距
        layout.minimumLineSpacing = 0
        // 列间距
        layout.minimumInteritemSpacing = 5
        // 内局
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        
        let collectionView = UICollectionView.init(frame: CGRect(x:0, y:0, width: ScreenWidth, height:100), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
        
        collectionView.register(GoodCollectionCell.classForCoder(), forCellWithReuseIdentifier: "goodCollectionCell")
        collectionView.register(CategoryCollectionCell.classForCoder(), forCellWithReuseIdentifier: "categoryCollectionCell")
        collectionView.register(ActivityCollectionCell.classForCoder(), forCellWithReuseIdentifier: "activityCollectionCell")
        collectionView.register(SearchCollectionCell.classForCoder(), forCellWithReuseIdentifier: "searchCollectionCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "goodCollectionCell", for: indexPath) as! GoodCollectionCell
        case 1:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "categoryCollectionCell", for: indexPath) as! CategoryCollectionCell
        case 2:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "activityCollectionCell", for: indexPath) as! ActivityCollectionCell
        default:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "searchCollectionCell", for: indexPath) as! SearchCollectionCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 3:
            controller?.performSegue(withIdentifier: "searchSegue", sender: nil)
        default:
            return
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
