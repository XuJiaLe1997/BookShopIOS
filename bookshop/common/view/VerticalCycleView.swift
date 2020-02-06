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
    
    // 每一次展示两行，第一行是当前行
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
        
        // 使用6个Label占位，每次显示的实际上是第3、4个Lable
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
        // MARK: 做了一些化简，原始逻辑参考Git提交记录
        for i in 0...5 {
            let item = delegate.cycleItemFor(getNext(currentIndex, offset: i - 2))
            itemTextViews[i].text = item.text
            itemTagViews[i].text = item.tag
            itemTagViews[i].textColor = tagColor(item.tag)
        }
        
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
        // 从 1/3 的高度滑动到 1/2 的位置，相当于滑动 1/6 的距离
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
        
        // MARK: 做了一些化简，原始逻辑参考Git提交记录
        for i in 1...5 {
            if scrollView.contentOffset.y < CGFloat(i) * itemH {
                if i != 3 {
                    currentIndex = getNext(currentIndex, offset: i - 3)
                }
                break
            } else if i == 5 {
                currentIndex = getNext(currentIndex, offset: 3)
            }
        }

    }
    
    // 获取下一条(或N条)标签
    fileprivate func getNext(_ current: Int, offset: Int = 1) -> Int {
        let count = numberOfItem - 1
        if (count < 1) {
            return 0
        }
        return (numberOfItem + (current + offset) % numberOfItem) % numberOfItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

