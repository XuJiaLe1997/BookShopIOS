//
//  ImageUtil.swift
//  bookshop
//
//  Created by Xujiale on 2020/1/4.
//  Copyright © 2020 xujiale. All rights reserved.
//

/*
 * 图片处理工具，常见的对图片尺寸等操作
 *
 * 参考：https://www.jianshu.com/p/0402e470e8c3
 */

import Foundation
import UIKit

class ImageUtil {
    
    //MARK: - 生成指定尺寸的纯色图片
    static func getWithPureColor(color: UIColor!, size: CGSize) -> UIImage{
        var size = size
        if size.equalTo(CGSize.zero){
            size = CGSize.init(width: 1, height: 1)
        }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    //MARK: - 修改图片尺寸
    static func resize(image: UIImage, size: CGSize) -> UIImage{
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        // Determine whether the screen is retina
        if UIScreen.main.scale == 2.0{
            UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
        }else{
            UIGraphicsBeginImageContext(size)
        }
        
        // 绘制改变大小的图片
        image.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        
        // 从当前context中创建一个改变大小后的图片
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 使当前的context出堆栈
        UIGraphicsEndImageContext()
        
        // 返回新的改变大小后的图片
        return scaledImage!
    }
    
    //MARK: - 压缩图片大小
    
}
