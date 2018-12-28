//
//  UIScreen+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

extension UIScreen {
    
    public static let SCREEN_W_4: CGFloat  = 320.0;
    public static let SCREEN_H_4: CGFloat  = 480.0;
    public static let SCREEN_W_5S: CGFloat = 320.0;
    public static let SCREEN_H_5S: CGFloat = 568.0;
    public static let SCREEN_W_6: CGFloat  = 375.0;
    public static let SCREEN_H_6: CGFloat  = 667.0;
    public static let SCREEN_W_6P: CGFloat = 414.0;
    public static let SCREEN_H_6P: CGFloat = 736.0;
    public static let SCREEN_W_X: CGFloat  = 375.0;//!<iPhoneX屏幕宽度
    public static let SCREEN_H_X: CGFloat  = 812.0;//!<iPhoneX屏幕高度
    public static let SCREEN_W_XR: CGFloat = 414.0;//!<iPhoneXsMax,iPhoneXR屏幕宽度
    public static let SCREEN_H_XR: CGFloat = 896.0;//!<iPhoneXsMax,iPhoneXR屏幕高度
    
    
    public static var kHeight: CGFloat {
        return self.main.bounds.height >  self.main.bounds.width ? self.main.bounds.height : self.main.bounds.width
    }
    public static var kWidth: CGFloat {
        return self.main.bounds.height <= self.main.bounds.width ? self.main.bounds.height : self.main.bounds.width
    }
    
    /// 是否是iPhoneX系列(刘海屏)
    public static var isiPhoneXMore: Bool {
        if (kWidth == SCREEN_W_X) && (kHeight == SCREEN_H_X) {
            return true
        }
        if (kWidth == SCREEN_W_XR) && (kHeight == SCREEN_H_XR) {
            return true
        }
        return false
    }
}
