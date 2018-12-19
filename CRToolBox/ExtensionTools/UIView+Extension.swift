//
//  UIView+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

extension UIView {
    
    /// x
    public var cr_x: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    public var cr_y: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    public var cr_height: CGFloat {
        get { return frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    public var cr_width: CGFloat {
        get { return frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width  = newValue
            frame = tempFrame
        }
    }
    
    /// size
    public var cr_size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size        = newValue
            frame                 = tempFrame
        }
    }
    
    /// centerX
    public var cr_centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    
    /// centerY
    public var cr_centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter;
        }
    }
    
    /// bottom
    public var cr_bottom: CGFloat {
        get { return cr_y + cr_height }
        set(newVal) {
            cr_y = newVal - cr_height
        }
    }
    
    /// 分割图
    public static func segmentView(color: UIColor = .cr_hexColor("#FFFFFF")) -> UIView {
        let tempView = UIView()
        tempView.backgroundColor = color
        return tempView
    }
    
    /// 移除所有的子视图
    public func clearAllSubViews() {
        if self.subviews.count > 0 {
            self.subviews.forEach { (subV) in
                subV.removeFromSuperview()
            }
        }
    }

}
