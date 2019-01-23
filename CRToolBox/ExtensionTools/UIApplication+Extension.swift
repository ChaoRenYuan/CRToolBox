//
//  UIApplication+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/1/23.
//  Copyright © 2019 CR. All rights reserved.
//

import UIKit

public extension UIApplication {

    /// 拿到window
    public func mainWindow() -> UIWindow? {
        return self.delegate?.window ?? nil
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
    
    /// 静态取NC
    public static let visibleStaticNC: UINavigationController = {
        return UIApplication.shared.visibleVC().navigationController ?? UINavigationController()
    }()
    
    /// 方法取NC
    public func visibleNC() -> UINavigationController {
        return self.visibleVC().navigationController ?? UINavigationController()
    }
    
}



