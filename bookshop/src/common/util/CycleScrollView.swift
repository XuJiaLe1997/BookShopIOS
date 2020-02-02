//
//  CycleScrollView.swift
//  bookshop
//
//  Created by Xujiale on 2019/12/19.
//  Copyright © 2019 xujiale. All rights reserved.
//

import Foundation
import UIKit

/*
 * 图片轮播器
 *
 * 基本原理：使用一个横向可容纳三张图片的ScrollerView，始终只显示中间的
 * 图片，每一次滑动结束后，重新设置左右相邻的图片，详细看代码。
 *
 * 参考：https://www.jianshu.com/p/32e5fbec3562
 */

// 代理（协议），类似Java中的interface，调用者实现该协议以便定制自己的轮播器
protocol CycleScrollViewDelegate: NSObjectProtocol {
    
    // 图片数量
    func cycleImageCount() -> Int
    
    // 设置当前页面
    func cycleImageView(_ imageView: UIImageView, index: Int)
    
    // 点击图片下标
    func cycleImageViewClick(_ index: Int)
}

class CycleScrollView: UIView, UIScrollViewDelegate {
    
    fileprivate var scrollView: UIScrollView!
    
    fileprivate var pageControl: MPageControl!
    
    fileprivate weak var delegate: CycleScrollViewDelegate?
    
    // 图片数组
    fileprivate var imageViews: [UIImageView] = []
    
    // 图片阴影数组
    fileprivate var shadowViews: [UIView] = []
    
    // 图片个数
    fileprivate var imageCount: Int = 0
    
    // 计时器
    fileprivate var timer: Timer?
    
    // 当前页面
    fileprivate var currentPage = 0 {
        didSet {
            updateImage()
        }
    }
    
    // 滚动间隔
    public var rollingTime: TimeInterval = 4.0
    
    // 是否滚动
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
    
    // 初始化
    init(frame: CGRect, delegate: CycleScrollViewDelegate) {
        super.init(frame: frame)
        
        self.delegate = delegate
        imageCount = delegate.cycleImageCount()
        
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isScrollEnabled = imageCount > 1
        addSubview(scrollView)
        
        pageControl = MPageControl(frame: CGRect(x: 0, y: frame.height - 50, width: frame.width, height: 50), numberOfPages: imageCount)
        pageControl.currentPage = 0
        pageControl.currentWidthMultiple = 2.5
        pageControl.currentColor = .blue
        pageControl.otherColor = .gray
        pageControl.pointSize = CGSize(width: 14, height: 8)
        pageControl.setClickAction { (index) in
            self.pageChanged(index!)
        }
        addSubview(pageControl)
        
        for _ in 0..<3 {
            let imageView = UIImageView()
            let shadowView = UIView()
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction(_:))))
            shadowView.addSubview(imageView)
            scrollView.addSubview(shadowView)
            shadowViews.append(shadowView)
            imageViews.append(imageView)
        }
        
    }
    
    // 设置初始布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width / 2)
        scrollView.contentSize = CGSize(width: frame.width * 3, height: frame.width / 2)
        
        for i in 0..<3 {
            shadowViews[i].frame = CGRect(x: 10 + CGFloat(i) * frame.width, y: 0, width: frame.width - 20, height: (frame.width - 20) / 3)
            shadowViews[i].layer.cornerRadius = 10
            shadowViews[i].layer.shadowColor = UIColor.lightGray.cgColor
            shadowViews[i].layer.shadowRadius = 10
            shadowViews[i].layer.shadowOffset = CGSize(width: 0, height: 10)
            shadowViews[i].layer.shadowOpacity = 0.8
            
            imageViews[i].frame = CGRect(x: 0, y: 0, width: frame.width - 20, height: (frame.width - 20) / 3)
            imageViews[i].layer.cornerRadius = 10
            imageViews[i].layer.masksToBounds = true
        }
        
        updateImage()
    }
    
    // 切换结束后，更新这三张图片
    fileprivate func updateImage() {
        delegate?.cycleImageView(imageViews[0], index: getLast(currentPage))
        delegate?.cycleImageView(imageViews[1], index: currentPage)
        delegate?.cycleImageView(imageViews[2], index: getNext(currentPage))
        scrollView.contentOffset.x = frame.width
    }
    
    func pageChanged(_ index: Int) {
        stopTimer()
        pageControl.currentPage = index
        currentPage = index
        updateImage()
        startTimer()
    }
    
    // 使用手势处理点击事件
    @objc fileprivate func tapAction(_ gesture: UITapGestureRecognizer) {
        delegate?.cycleImageViewClick(currentPage)
    }
    
    // 开始计时器
    fileprivate func startTimer() {
        if (imageCount < 2) {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: rollingTime, target: self, selector: #selector(rolling), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    // 暂停计时器
    fileprivate func stopTimer() {
        if (imageCount < 2) {
            return
        }
        timer?.invalidate()
        timer = nil
    }
    
    // 计时方法
    @objc fileprivate func rolling() {
        scrollView.setContentOffset(CGPoint(x: frame.width * 2, y: 0), animated: true)
    }
    
    // scrollView 开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if rollingEnable {
            stopTimer()
        }
    }
    
    // scrollView 结束拖拽
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if rollingEnable {
            startTimer()
        }
    }
    
    // scrollView 滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= 0 {
            currentPage = getLast(currentPage)
        } else if scrollView.contentOffset.x >= 2 * scrollView.frame.width {
            currentPage = getNext(currentPage)
        }
        pageControl.currentPage = currentPage
    }
    
    // 获取下一页页码
    fileprivate func getNext(_ current: Int) -> Int {
        let count = imageCount - 1
        if (count < 1) {
            return 0
        }
        return current + 1 > count ? 0 : current + 1
    }
    
    // 获取上一页页码
    fileprivate func getLast(_ current: Int) -> Int {
        let count = imageCount - 1
        if (count < 1) {
            return 0
        }
        return current - 1 < 0 ? count : current - 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
