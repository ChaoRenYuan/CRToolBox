//
//  UIButton+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

extension UIButton {

    /// 自定义UIButton初始化
    /// @param: isForceRightToLeft将Button的图片和文本交换位置
    public convenience init(text: String? = nil, textColor: UIColor? = nil, font: UIFont? = nil, bgColor: UIColor? = nil, target: Any? = nil, btnSelector: Selector? = nil, isForceRightToLeft: Bool? = nil) {
        
        self.init()
        if let btnTitle = text {
            self.setTitle(btnTitle, for: .normal)
        }
        if let titleForColor = textColor {
            self.setTitleColor(titleForColor, for: .normal)
        }
        if let tempFont = font {
            self.titleLabel?.font = tempFont
        }
        if let btnBgColor = bgColor {
            self.backgroundColor = btnBgColor
        }
        if let btnTarget = target, let selector = btnSelector {
            self.addTarget(btnTarget, action: selector, for: .touchUpInside)
        }
        if let forceRightToLeft = isForceRightToLeft, forceRightToLeft {
            if forceRightToLeft {
                self.semanticContentAttribute = .forceRightToLeft
            }
        }
    }
    
}
