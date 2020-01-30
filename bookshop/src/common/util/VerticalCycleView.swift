//
//  HCycleScrollView.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/30.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

/*
 * 垂直文字轮播器
 */

protocol VerticalCycleViewDelegate: NSObjectProtocol {
    
    func cycleItemCount() -> Int
    
    // 每个item样式包括前面的彩色标记和后面的文本描述
    func cycleItemFor(_ index: Int) -> (text: String, tag: String)
    
    func cycleItemClick(_ index: Int)
}

class VerticalCycleView: UIView, UIScrollViewDelegate {
    
    fileprivate var scrollView: UIScrollView!
    
    fileprivate weak var delegate: VerticalCycleViewDelegate!
    
    fileprivate var itemTextViews: [UILabel] = [UILabel]()
    
    fileprivate var itemTagViews: [UILabel] = [UILabel]()
    
    fileprivate var numberOfItem: Int = 0
    
    fileprivate var timer: Timer?
    
    // 每一次展示两行，默认第一行是当前行
    fileprivate var currentIndex = 0 {
        didSet {
            updateItems()
        }
    }
    
    // 滚动间隔
    public var rollingTime: TimeInterval = 3.0
    
    public var rollingEnable: Bool = false {
        willSet {
            if newValue != rollingEnable {
                if newValue {
                    startTimer()
                } else {
                    stopTimer()
                }
            }
        }
    }
    
    convenience init(frame: CGRect, delegate: VerticalCycleViewDelegate) {
        self.init(frame: frame)
        self.delegate = delegate
        numberOfItem = delegate.cycleItemCount()
        scrollView.isScrollEnabled = numberOfItem > 1
    }
    
    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        addSubview(scrollView)
        
        for _ in 0..<6 {
            let textView = UILabel()
            scrollView.addSubview(textView)
            itemTextViews.append(textView)
            textView.textAlignment = NSTextAlignment.left
            textView.font = UIFont.systemFont(ofSize: 15)
            
            let tagView = UILabel()
            tagView.font = UIFont.systemFont(ofSize: 15)
            scrollView.addSubview(tagView)
            itemTagViews.append(tagView)
        }
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction(_:))))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        scrollView.contentSize = CGSize(width: frame.width, height: frame.height * 3)
        
        var i = 0
        for lable in itemTextViews {
            lable.frame = CGRect(x: 40, y: CGFloat(i) * frame.height/2, width: frame.width - 40, height: frame.height/2)
            lable.isUserInteractionEnabled = true
            i += 1
        }
        
        i = 0
        for label in itemTagViews {
            label.frame = CGRect(x: 0, y: CGFloat(i) * frame.height/2, width: 40, height: frame.height/2)
            i += 1
        }
        
        updateItems()
    }
    
    fileprivate func updateItems() {
        
        var item = delegate.cycleItemFor(getLast(currentIndex, offset: 2))
        itemTextViews[0].text = item.text
        itemTagViews[0].text = item.tag
        itemTagViews[0].textColor = tagColor(item.tag)
        
        item = delegate.cycleItemFor(getLast(currentIndex))
        itemTextViews[1].text = item.text
        itemTagViews[1].text = item.tag
        itemTagViews[1].textColor = tagColor(item.tag)
        
        item = delegate.cycleItemFor(currentIndex)
        itemTextViews[2].text = item.text
        itemTagViews[2].text = item.tag
        itemTagViews[2].textColor = tagColor(item.tag)
        
        item = delegate.cycleItemFor(getNext(currentIndex))
        itemTextViews[3].text = item.text
        itemTagViews[3].text = item.tag
        itemTagViews[3].textColor = tagColor(item.tag)
        
        item = delegate.cycleItemFor(getNext(currentIndex, offset: 2))
        itemTextViews[4].text = item.text
        itemTagViews[4].text = item.tag
        itemTagViews[4].textColor = tagColor(item.tag)
        
        item = delegate.cycleItemFor(getNext(currentIndex, offset: 3))
        itemTextViews[5].text = item.text
        itemTagViews[5].text = item.tag
        itemTagViews[5].textColor = tagColor(item.tag)
        
        scrollView.contentOffset.y = frame.height
    }
    
    fileprivate func tagColor(_ tag: String) -> UIColor{
        switch tag {
        case "Hot":
            return UIColor.red
        case "好评":
            return UIColor.orange
        default:
            return UIColor.blue
        }
    }
    
    // 使用手势响应点击事件
    @objc fileprivate func tapAction(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view)
        // 区分点击第一行还是第二行
        if(point.y <= frame.height/2) {
            delegate.cycleItemClick(currentIndex)
        } else {
            delegate.cycleItemClick(getNext(currentIndex))
        }
    }
    
    fileprivate func startTimer() {
        if (numberOfItem < 2) {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: rollingTime, target: self, selector: #selector(rolling), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    fileprivate func stopTimer() {
        if (numberOfItem < 2) {
            return
        }
        timer?.invalidate()
        timer = nil
    }
    
    // 每次自动滚动一行的高度
    @objc fileprivate func rolling() {
        scrollView.setContentOffset(CGPoint(x: 0, y: frame.height*3/2), animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if rollingEnable {
            stopTimer()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if rollingEnable {
            startTimer()
        }
    }
    
    // 滚动结束后重新计算当前行
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let itemH = scrollView.frame.height/2
        
        if scrollView.contentOffset.y < itemH {
            currentIndex = getLast(currentIndex, offset: 2)
        } else if scrollView.contentOffset.y < 2 * itemH {
            currentIndex = getLast(currentIndex)
        } else if scrollView.contentOffset.y < 3 * itemH {

        } else if scrollView.contentOffset.y < 4 * itemH {
            currentIndex = getNext(currentIndex)
        } else if scrollView.contentOffset.y < 5 * itemH {
            currentIndex = getNext(currentIndex, offset: 2)
        } else {
            currentIndex = getNext(currentIndex, offset: 3)
        }
    }
    
    // 获取下一条(或N条)标签
    fileprivate func getNext(_ current: Int, offset: Int = 1) -> Int {
        let count = numberOfItem - 1
        if (count < 1) {
            return 0
        }
        return (current + offset) % numberOfItem
    }
    
    // 获取上一条(或N条)标签
    fileprivate func getLast(_ current: Int, offset: Int = 1) -> Int {
        let count = numberOfItem - 1
        if (count < 1) {
            return 0
        }
        return (numberOfItem + (current - offset) % numberOfItem) % numberOfItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

