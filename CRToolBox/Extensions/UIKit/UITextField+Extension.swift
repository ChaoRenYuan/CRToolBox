//
//  UITextField+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

extension UITextField {
    
    /// 自定义UITextField初始化
    public convenience init(tfText: String? = nil, textColor: UIColor? = nil, font: UIFont? = nil, bgColor: UIColor? = nil, placeholderText: String? = nil, attributed: NSAttributedString? = nil) {
        self.init()
        // 设置标题
        if let tempText = tfText {
            self.text = tempText
        }
        // 设置标题颜色
        if let color = textColor {
            self.textColor = color
        }
        //设置字体大小
        if let fontResult = font {
            self.font = fontResult
        }
        //设置背景颜色
        if let bgColorResult = bgColor {
            self.backgroundColor = bgColorResult
        }
        // 设置占位符
        if let tempPlaceholder = placeholderText {
            self.placeholder = tempPlaceholder
        }
        // 设置占位符的富文本
        if let tempAttributedPlaceholder = attributed {
            self.attributedPlaceholder = tempAttributedPlaceholder
        }
    }
    
}
