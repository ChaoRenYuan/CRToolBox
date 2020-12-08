//
//  UIImage+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/12/7.
//  Copyright © 2019 CR. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 给我一个颜色，还你一个图片
    public class func imgWithColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        /// 开始绘制
        UIGraphicsBeginImageContext(rect.size)
        /// 获取当前上下文
        let context = UIGraphicsGetCurrentContext()
        /// 上下文获取该颜色
        context?.setFillColor(color.cgColor)
        /// 用这个颜色填充这个上下文
        context?.fill(rect)
        //从这段上下文中获取Image
        let img = UIGraphicsGetImageFromCurrentImageContext()
        /// 结束绘制
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
    
}


