//
//  HomeFunctionCell.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/19.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

class HomeFunctionCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let ScreenWidth  = UIScreen.main.bounds.width
    let numberOfFunction = 4
    var controller: UIViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let layout = UICollectionViewFlowLayout.init()
        // 行间距
        layout.minimumLineSpacing = 0
        // 最小列间距
        layout.minimumInteritemSpacing = 5
        // item平分(减去间距后的)屏幕宽度，但不应小于60，否则允许水平滑动
        var w = (ScreenWidth - layout.minimumInteritemSpacing * CGFloat(numberOfFunction - 1))/CGFloat(numberOfFunction)
        if(w < 60) {
            w = 60
            layout.scrollDirection = .horizontal
        }
        layout.itemSize = CGSize(width: w, height: 100)
        
        
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
        return numberOfFunction
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
            CBToast.showToastAction(message: "功能尚未开放")
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
