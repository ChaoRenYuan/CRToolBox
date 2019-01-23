//
//  UIViewController+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/1/23.
//  Copyright © 2019 CR. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// present
    public func presentShow(animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            var topRootVC = UIApplication.shared.keyWindow?.rootViewController
            while topRootVC?.presentedViewController != nil {
                topRootVC = topRootVC?.presentedViewController
            }
            topRootVC?.present(self, animated: animated, completion: completion)
        }
    }
    
    /// dismissToRootVC
    public func dismissToRootVC() {
        var rootVC = self.presentingViewController
        while let parent = rootVC?.presentingViewController {
            rootVC = parent
        }
        rootVC?.dismiss(animated: true, completion: nil)
    }
    
}
