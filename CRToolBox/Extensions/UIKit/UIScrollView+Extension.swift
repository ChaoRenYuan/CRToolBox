//
//  UIScrollView+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/12/7.
//  Copyright © 2019 CR. All rights reserved.
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

import EmptyDataSet_Swift

/**
 *      没有网络的处理
 */
extension UIScrollView {

    struct NonNetworking {
        static var isNonNetworkingKey = "NonNetworkingKey"
    }

    var isNonNetworking: Bool {
        get {
            if let isNonNetworkingKey = objc_getAssociatedObject(self, &NonNetworking.isNonNetworkingKey) as? Bool {
                return isNonNetworkingKey
            }
            return false
        }
        set {
            objc_setAssociatedObject(self, &NonNetworking.isNonNetworkingKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            reloadEmptyDataSet()
        }
    }

    func setNonNetworking(customView: UIView, backgroundColor: UIColor, verticalOffset: CGFloat) {
        let customView = customView
        emptyDataSetView { [weak self] (view) in
            view.verticalOffset(verticalOffset)
            .shouldDisplay(self?.isNonNetworking ?? false)
            .isScrollAllowed(false)
            .dataSetBackgroundColor(backgroundColor)
            .customView(customView)
        }
    }
}

/**
 *      没有数据的处理
 */
extension UIScrollView {

    struct NonDataSources {
        static var isNonDataSourcesKey = "NonDataSources"
    }
    
    var isNonDataSources: Bool {
        get {
            if let tempV = objc_getAssociatedObject(self, &NonDataSources.isNonDataSourcesKey) as? Bool {
                return tempV
            }
            return false
        }
        set {
            objc_setAssociatedObject(self, &NonDataSources.isNonDataSourcesKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            reloadEmptyDataSet()
        }
    }

    func setNonDataSources(customView: UIView, verticalOffset: CGFloat, backgroundColor: UIColor) {
        emptyDataSetView { [weak self] (view) in
            view.verticalOffset(verticalOffset)
            .shouldDisplay(self?.isNonDataSources ?? false)
            .isScrollAllowed(true)
            .dataSetBackgroundColor(backgroundColor)
            .customView(customView)
        }
    }
}
