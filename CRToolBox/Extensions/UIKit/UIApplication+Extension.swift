//
//  UIApplication+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/1/23.
//  Copyright © 2019 CR. All rights reserved.
//

import UIKit

extension UIApplication {

    /// 拿到window
    public func mainWindow() -> UIWindow? {
        if #available(iOS 13, *) {
            var window: UIWindow?
            for windowScene: UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
                if windowScene.activationState == .foregroundActive {
                    window = windowScene.windows.first
                    break
                }
            }
            return window
        } else {
            return self.delegate?.window ?? nil
        }
    }
    
    /// 拿到当前VC
    public func visibleVC() -> UIViewController {
        let rootVC = self.mainWindow()?.rootViewController
        return self.getVisibleVCWith(vc: rootVC ?? UIViewController())
    }
    
    /// 匹配当前VC
    public func getVisibleVCWith(vc: UIViewController) -> UIViewController {
        
        if vc.isKind(of: UINavigationController.classForCoder()) {
            return self.getVisibleVCWith(vc: (vc as? UINavigationController)?.visibleViewController ?? UIViewController())
            
        } else if vc.isKind(of: UITabBarController.classForCoder()) {
            return self.getVisibleVCWith(vc: (vc as? UITabBarController)?.selectedViewController ?? UIViewController())
        } else {
            if vc.presentedViewController != nil {
                return self.getVisibleVCWith(vc: vc.presentedViewController ?? UIViewController())
            } else {
                return vc
            }
        }
        
    }
    
    /// 方法取NC
    public func visibleNC() -> UINavigationController {
        return self.visibleVC().navigationController ?? UINavigationController()
    }
    /// 设置状态栏
    public var statusBarV: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 1101
            if let statusBar = self.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag

                self.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
    /// 状态栏的高度
    public var statusBarH: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
}
