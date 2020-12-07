//
//  UIScrollView+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/12/7.
//  Copyright © 2020 CR. All rights reserved.
//

import UIKit

/**
 * 长截图
 */
extension UIScrollView {
    
    public func screenshot() -> UIImage? {
        
        let savedContentOffset = contentOffset
        let savedFrame = frame
        
        var size = contentSize
        if contentSize.width <= 0 {
            size = CGSize(width: savedFrame.size.width, height: contentSize.height)
        }
        
        contentOffset = CGPoint.zero
        frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        var image: UIImage?
        if let currentContent = UIGraphicsGetCurrentContext() {
            layer.render(in: currentContent)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        
        //drawHierarchy(in: frame, afterScreenUpdates: false)
        //let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        contentOffset = savedContentOffset
        frame = savedFrame
        
        return image
    }
    
    /// 禁止下拉
    public func forbidPullDown(_ scrollView: UIScrollView) {
        let tempY = scrollView.contentOffset.y
        if tempY < 0 {
            contentOffset.y = 0
        } else {
            contentOffset.y = tempY
        }
    }

}
