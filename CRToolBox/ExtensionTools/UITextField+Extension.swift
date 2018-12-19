//
//  UITextField+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

public extension UITextField {
    convenience init(placeText: String? = nil, textColor: UIColor? = nil, font: UIFont? = nil, bgColor: UIColor? = nil) {
        self.init()
        //设置标题
        if let title = placeText {
            self.placeholder = title
        }
        //设置标题颜色
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
    }
}
