//
//  MPageControl.swift
//  bookshop
//
//  Created by Xujiale on 2020/2/2.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

class MPageControl: UIControl {
    
    fileprivate var localNumberOfPages = NSInteger()        // 分页数量
    fileprivate var localCurrentPage = NSInteger()          // 当前点所在下标
    fileprivate var localPointSize = CGSize()               // 点的大小
    fileprivate var localPointSpace = CGFloat()             // 点之间的间距
    fileprivate var localOtherColor = UIColor()             // 未选中点的颜色
    fileprivate var localCurrentColor = UIColor()           // 当前点的颜色
    fileprivate var localOtherImage: UIImage?               // 未选中点的图片
    fileprivate var localCurrentImage: UIImage?             // 当前点的图片
    fileprivate var localIsSquare = Bool()                  // 是否是方形点
    fileprivate var localCurrentWidthMultiple = CGFloat()   // 当前选中点宽度与未选中点的宽度的倍数
    fileprivate var localOtherBorderColor: UIColor?         // 未选中点的layerColor
    fileprivate var localOtherBorderWidth: CGFloat?         // 未选中点的layer宽度
    fileprivate var localCurrentBorderColor: UIColor?       // 未选中点的layerColor
    fileprivate var localCurrentBorderWidth: CGFloat?       // 未选中点的layer宽度
    fileprivate var clickIndex: ((_ index: NSInteger?) -> ())?
    
    fileprivate var pointViews: [PointView] = []
    
    init(frame: CGRect, numberOfPages: NSInteger, currentPage: NSInteger = 0) {
        super.init(frame: frame)
        
        // 默认设置
        localNumberOfPages = numberOfPages
        localCurrentPage = currentPage
        localPointSize = CGSize.init(width: 6, height: 6)
        localPointSpace = 8
        localIsSquare = false
        localOtherColor = UIColor.init(white: 1, alpha: 0.5)
        localCurrentColor = UIColor.white
        localCurrentWidthMultiple = 1
        creatPointView()
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 暴露可修改的属性
    
    var numberOfPages: NSInteger {
        set {
            if localNumberOfPages == newValue {
                return
            }
            localNumberOfPages = newValue
            creatPointView()
        }
        get {
            return self.localNumberOfPages
        }
    }
    
    var currentPage: NSInteger {
        set {
            if localCurrentPage == newValue {
                return
            }
            exchangeCurrentView(oldSelectedIndex: localCurrentPage, newSelectedIndex: newValue)
            localCurrentPage = newValue
        }
        get {
            return self.localCurrentPage
        }
    }
    
    var pointSize: CGSize {
        set {
            if localPointSize != newValue {
                localPointSize = newValue
                creatPointView()
            }
        }
        get {
            return self.localPointSize
        }
    }
    
    var pointSpace: CGFloat {
        set {
            if localPointSpace != newValue{
                localPointSpace = newValue
                creatPointView()
            }
        }
        get {
            return self.localPointSpace
        }
    }
    
    var otherColor: UIColor {
        set {
            if localOtherColor != newValue {
                localOtherColor = newValue
                creatPointView()
            }
        }
        get {
            return self.localOtherColor
        }
    }
    
    var currentColor: UIColor {
        set {
            if localCurrentColor != newValue {
                localCurrentColor = newValue
                creatPointView()
            }
        }
        get {
            return self.localCurrentColor
        }
    }
    
    var otherImage: UIImage {
        set {
            if localOtherImage != newValue {
                localOtherImage = newValue
                creatPointView()
            }
        }
        get {
            return self.localOtherImage!
        }
    }
    
    var currentImage: UIImage {
        set{
            if localCurrentImage != newValue {
                localCurrentImage = newValue
                creatPointView()
            }
        }
        get {
            return self.localCurrentImage!
        }
    }
    
    var isSquare: Bool {
        set {
            if localIsSquare != newValue {
                localIsSquare = newValue
                creatPointView()
            }
        }
        get {
            return self.localIsSquare
        }
    }
    
    var currentWidthMultiple: CGFloat {
        set {
            if localCurrentWidthMultiple != newValue {
                localCurrentWidthMultiple = newValue
                creatPointView()
            }
        }
        get {
            return self.localCurrentWidthMultiple
        }
    }
    
    var otherBorderColor: UIColor {
        set {
            localOtherBorderColor = newValue
            creatPointView()
        }
        get {
            return self.localOtherBorderColor!
        }
    }
    
    var otherBorderWidth: CGFloat {
        set {
            localOtherBorderWidth = newValue
            creatPointView()
        }
        get {
            return self.localOtherBorderWidth!
        }
    }
    
    var currentBorderColor: UIColor {
        set {
            localCurrentBorderColor = newValue
            creatPointView()
        }
        get {
            return self.localCurrentBorderColor!
        }
    }
    
    var currentBorderWidth: CGFloat {
        set {
            localCurrentBorderWidth = newValue
            creatPointView()
        }
        get {
            return self.localCurrentBorderWidth!
        }
    }
    
    func setClickAction(index: @escaping (_ index: NSInteger?) -> ()) {
        self.clickIndex = index;
    }
    
    // MARK: 创建小圆点
    
    func creatPointView() {
        
        // 每次修改属性后都会调用此方法，所以去除重复添加的subviews
        for view in self.subviews {
            view.removeFromSuperview()
        }
        pointViews.removeAll()
        
        if localNumberOfPages <= 0 {
            return
        }
        
        var startX: CGFloat = 0
        var startY:CGFloat = 0
        let mainWidth = CGFloat(localNumberOfPages) * (localPointSize.width + localPointSpace)
        
        if self.frame.size.width > mainWidth {
            startX = (self.frame.size.width - mainWidth) / 2
        }
        
        if self.frame.size.height > localPointSize.height {
            startY = (self.frame.size.height - localPointSize.height) / 2
        }
        
        for index in 0 ..< numberOfPages {
            if index == localCurrentPage {
                let currentPointViewWidth = localPointSize.width * localCurrentWidthMultiple
                let currentPointView = PointView(frame: CGRect(x: startX, y: startY, width: currentPointViewWidth, height: localPointSize.height), index: index)
                currentPointView.backgroundColor = localCurrentColor
                currentPointView.layer.cornerRadius = localIsSquare ? 0 : localPointSize.height / 2
                currentPointView.layer.masksToBounds = true
                currentPointView.layer.borderColor = localCurrentBorderColor != nil ? localCurrentBorderColor?.cgColor : localCurrentColor.cgColor
                currentPointView.layer.borderWidth = localCurrentBorderWidth != nil ? localCurrentBorderWidth! : 0
                currentPointView.isUserInteractionEnabled = true
                currentPointView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickAction(_:))))
                if localCurrentImage != nil {
                    currentPointView.imageView.image = localCurrentImage
                }
                
                self.addSubview(currentPointView)
                pointViews.append(currentPointView)
                startX = currentPointView.frame.maxX + localPointSpace
            } else {
                let otherPointView = PointView(frame: CGRect(x: startX, y: startY, width: localPointSize.width, height: localPointSize.height), index: index)
                otherPointView.backgroundColor = localOtherColor
                otherPointView.layer.cornerRadius = localIsSquare ? 0 : localPointSize.height / 2;
                otherPointView.layer.borderColor = localOtherBorderColor != nil ? localOtherBorderColor?.cgColor : localOtherColor.cgColor
                otherPointView.layer.borderWidth = localOtherBorderWidth != nil ? localOtherBorderWidth! : 0
                otherPointView.layer.masksToBounds = true
                otherPointView.isUserInteractionEnabled = true
                self.addSubview(otherPointView)
                let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(clickAction(_:)))
                otherPointView.addGestureRecognizer(tapGesture)
                startX = otherPointView.frame.maxX + localPointSpace
                
                if localOtherImage != nil {
                    otherPointView.imageView.image = localOtherImage
                }
                
                pointViews.append(otherPointView)
            }
        }
    }
    
    // MARK: 切换小圆点
    
    func exchangeCurrentView(oldSelectedIndex: NSInteger, newSelectedIndex: NSInteger) {
        
        let oldPointView = pointViews[oldSelectedIndex]
        let newPointView = pointViews[newSelectedIndex]
        
        oldPointView.layer.borderColor = localOtherBorderColor != nil ? localOtherBorderColor?.cgColor : localOtherColor.cgColor
        oldPointView.layer.borderWidth = localOtherBorderWidth != nil ? localOtherBorderWidth! : 0
        
        newPointView.layer.borderColor = localCurrentBorderColor != nil ? localCurrentBorderColor?.cgColor : localCurrentColor.cgColor
        newPointView.layer.borderWidth = localCurrentBorderWidth != nil ? localCurrentBorderWidth! : 0
        
        oldPointView.backgroundColor = localOtherColor
        newPointView.backgroundColor = localCurrentColor
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.localCurrentWidthMultiple != 1 { //如果当前选中点的宽度与未选中的点宽度不一样，则要改变选中前后两点的frame
                var oldPointFrame = oldPointView.frame
                if newSelectedIndex < oldSelectedIndex {
                    oldPointFrame.origin.x += self.localPointSize.width * (self.localCurrentWidthMultiple - 1)
                }
                oldPointFrame.size.width = self.localPointSize.width
                oldPointView.frame = oldPointFrame
                
                var newPointFrame = newPointView.frame
                if newSelectedIndex > oldSelectedIndex {
                    newPointFrame.origin.x -= self.localPointSize.width * (self.localCurrentWidthMultiple - 1)
                }
                newPointFrame.size.width = self.localPointSize.width * self.localCurrentWidthMultiple
                newPointView.frame = newPointFrame
            }
            
            if newSelectedIndex - oldSelectedIndex > 1 { //点击圆点，中间有跳过的点
                for index in oldSelectedIndex + 1 ..< newSelectedIndex {
                    let view = self.pointViews[index]
                    var frame = view.frame
                    frame.origin.x -= self.localPointSize.width * (self.localCurrentWidthMultiple - 1)
                    frame.size.width = self.localPointSize.width
                    view.frame = frame
                }
            }
            
            if newSelectedIndex - oldSelectedIndex < -1 { //点击圆点，中间有跳过的点
                for index in newSelectedIndex + 1 ..< oldSelectedIndex {
                    let view = self.pointViews[index]
                    var frame = view.frame
                    frame.origin.x += self.localPointSize.width * (self.localCurrentWidthMultiple - 1)
                    frame.size.width = self.localPointSize.width
                    view.frame = frame
                }
            }
        })
        
        // 切换选中图片和未选中图片
        if localOtherImage != nil {
            oldPointView.imageView.image = localOtherImage
        }
        if localCurrentImage != nil {
            newPointView.imageView.image = localCurrentImage
        }
    }
    
    @objc func clickAction(_ sender: UITapGestureRecognizer) {//点击小圆点
        let pointView = sender.view as! PointView
        self.clickIndex?(pointView.index)
    }
    
}

fileprivate class PointView: UIView {
    
    var index: Int!
    var imageView: UIImageView!
    
    init(frame: CGRect, index: Int) {
        super.init(frame: frame)
        self.index = index
        imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
