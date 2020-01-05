//
//  WaterFallLayout.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/4.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

/*
 * 瀑布流布局，基本原理：将页面分成两列，通过frame属性进行定位。
 *
 * 参考：https://blog.csdn.net/weixin_41735943/article/details/83869801
 */

protocol WaterFallDelegate: NSObjectProtocol {
    // 获取item数量
    func getCount() -> Int
    // item的高度
    func heightFotItem(index: Int) -> CGFloat
}

class WaterFallLayout: UICollectionViewFlowLayout {

    var delegate: WaterFallDelegate!
    // 添加一个数组属性，用来存放每个item的布局信息
    var attributes:Array<UICollectionViewLayoutAttributes>?

    init(delegate: WaterFallDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    override func prepare() {
        super.prepare()
        // 设置为竖直布局
        self.scrollDirection = .vertical
        // 初始化数组
        attributes = Array<UICollectionViewLayoutAttributes>()
        // 间隔/边距
        let spacing = self.minimumInteritemSpacing
        let width = getItemWidth()
        // 定义一个元组表示每一列的动态高度
        var columnHeight:(one: CGFloat, two: CGFloat) = (0, 0)
        // 每一列的元素个数
        var itemInColumn:(one: Int, two: Int) = (0, 0)

        // 定义每个item的布局
        for index in 0..<delegate.getCount() {
            let attris = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: index, section: 0))
            // 获取item的高度
            let height:CGFloat = delegate.heightFotItem(index: index)
            // 哪列高度小就把新的item放那列下面
            var column = 0
            if columnHeight.one <= columnHeight.two {
                columnHeight.one += (height+CGFloat(spacing))
                itemInColumn.one += 1
                column = 0
            } else{
                columnHeight.two += (height+CGFloat(spacing))
                itemInColumn.two += 1
                column = 1
            }
            // 设置item的起始坐标
            let x = spacing + (spacing + width) * CGFloat(column)
            let y = column == 0 ? columnHeight.one-height : columnHeight.two-height
            attris.frame = CGRect(x: CGFloat(x) , y: CGFloat(y), width: width, height: CGFloat(height))
            
            attributes?.append(attris)
        }
        
        //以最大一列的高度计算每个item高度的平均值，滑动content需要item的size来确定
        var var1: CGFloat = 0.0, var2: Int = 0
        if(columnHeight.one > columnHeight.two) {
            var1 = columnHeight.one
            var2 = itemInColumn.one
        } else {
            var1 = columnHeight.two
            var2 = itemInColumn.two
        }
        self.itemSize = CGSize(width: width, height: var1/CGFloat(var2)-spacing)
    }
    
    // 计算item宽度，屏幕宽度减去左中右的间隔后平分为两列
    func getItemWidth() -> CGFloat {
        return (UIScreen.main.bounds.size.width - 3 * self.minimumInteritemSpacing) / 2
    }
    
    // 返回自定义的属性集合
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
}
