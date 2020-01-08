//
//  EWTextField.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/8.
//  Copyright © 2020 xujiale. All rights reserved.
//

import Foundation
import UIKit

/**
 * EW输入框
 * 效果：placeholder点击后上浮；密码明文切换
 *
 * 参考：https://github.com/WangLiquan/EWTextField
 */

class EWTextField: UITextField {
    
    // 文本框的底部横线
    private let bottomLine : CALayer = {
        let line = CALayer()
        line.backgroundColor = ColorUtil.use255Color(red: 79, green: 176, blue: 255, alpha: 1).cgColor
        line.isHidden = true
        return line
    }()
    
    // 使用label替换placeholder
    public let phLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = ColorUtil.use255Color(red: 51, green: 51, blue: 51, alpha: 0.4)
        label.textAlignment = .left
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        return label
    }()
    
    init(frame:CGRect,isSecure:Bool) {
        super.init(frame:frame)
        self.isSecureTextEntry = isSecure
        drawMyView()
        /// 添加字数判断
        //        addChangeTextTarget()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawMyView() {
        self.addSubview(phLabel)
        self.layer.addSublayer(bottomLine)
        if self.isSecureTextEntry {
            let passwordSwitch = PassowrdSwitch(frame: CGRect(x: 0, y: 0, width: 21, height: 12.5))
            passwordSwitch.addTarget(self, action: #selector(togglePasswordHidden(sender:)), for: .touchUpInside)
            self.rightView = passwordSwitch
            self.rightViewMode = .always
        }
    }
    
    func setTitle(_ title: String!, ofSize: CGFloat) {
        phLabel.text = title
        phLabel.font = UIFont.systemFont(ofSize: ofSize)
    }
    
    @objc func togglePasswordHidden(sender:PassowrdSwitch) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        sender.isSelected = !sender.isSelected
    }
    
    /// 将placeholder上移方法,点击空的textfield时调用
    public func placeholderUp() {
        UIView.animate(withDuration: 0.4) {
            self.phLabel.frame = CGRect(x: 0, y: -20, width: 100, height: 20)
            self.phLabel.font = UIFont.systemFont(ofSize: 14)
            self.phLabel.textColor = ColorUtil.use255Color(red: 79, green: 176, blue: 255, alpha: 1)
        }
    }
    public func changeLineHidden() {
        self.bottomLine.isHidden = !self.bottomLine.isHidden
    }
    
    /// placeholder下移方法,当文字清空时调用
    public func placeholderDown() {
        UIView.animate(withDuration: 0.4) {
            self.phLabel.frame = CGRect(x: 0, y: 0, width: 100, height: self.frame.size.height)
            self.phLabel.font = UIFont.systemFont(ofSize: 18)
            self.phLabel.textColor = ColorUtil.use255Color(red: 51, green: 51, blue: 51, alpha: 0.4)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let lineHeight = 1 / UIScreen.main.scale
        bottomLine.frame = CGRect(x: -6, y: self.bounds.height+3 - lineHeight, width: self.bounds.width+12, height: lineHeight)
    }
    
    /// 重写方法调整rightView.frame来实现密码状态下的眼睛按钮与非密码状态下的清空按钮对齐
    ///
    /// - Parameter bounds: textField.frame
    /// - Returns: rightView.frame
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 4
        return rect
    }
}
/// 密码形式的右侧明密文转换按钮
class PassowrdSwitch : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    func config() {
        self.setImage(UIImage(named:"close_eye"), for: .normal)
        self.setImage(UIImage(named:"open_eye"), for: .selected)
    }
}
