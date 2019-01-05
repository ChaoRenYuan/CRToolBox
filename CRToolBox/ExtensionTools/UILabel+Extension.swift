//
//  UILabel+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

public extension UILabel {
    
    /// 自定义UILabel初始化
    public convenience init(text: String? = nil, textColor: UIColor? = nil, font: UIFont? = nil, size: CGFloat? = nil, bgColor: UIColor? = nil, align: NSTextAlignment = .left) {
        self.init()
        //设置标题颜色
        if let color = textColor {
            self.textColor = color
        }
        // 设置文本
        if let textStr = text {
            self.text = textStr
        }
        //设置字体大小
        if let sizeResult = size {
            self.font = UIFont.systemFont(ofSize: sizeResult)
        }
        //设置字体
        if let fontResult = font {
            self.font = fontResult
        }
        //设置背景颜色
        if let bgColorResult = bgColor {
            self.backgroundColor = bgColorResult
        }
        self.textAlignment = align
    }
    
    /**
     * 富文本设置
     * @param:
     *  fullStr: 完整的text
     *  first*: 设置第一部分的Str
     *  other*: 设置其他部分的Str
     *  不设置的地方为UILabel原本的设置方法
     */
    public static func customAttributedText(fullStr: String, firstSetStr: String? = nil, firstFont: UIFont? = nil, firstColor: UIColor? = nil, firstBgColor: UIColor? = nil, otherSetStr: String? = nil, otherFont: UIFont? = nil, otherColor: UIColor? = nil, otherBgColor: UIColor? = nil) -> NSAttributedString {
        
        let string = fullStr
        
        let result = NSMutableAttributedString(string: string)
        //设置iOS的字体属性
        
        if firstSetStr != nil {
            var attributesForFirstWord = [NSAttributedStringKey: Any]()
            if let tempFont = firstFont {
                attributesForFirstWord[.font] = tempFont
            }
            if let tempColor = firstColor {
                attributesForFirstWord[.foregroundColor] = tempColor
            }
            if let tempBgColor = firstBgColor {
                attributesForFirstWord[.backgroundColor] = tempBgColor
            }
            result.setAttributes(attributesForFirstWord, range:(string as NSString).range(of: firstSetStr!) )
        }
        
        
        if otherSetStr != nil {
            var attributesForSecondWord = [NSAttributedStringKey : Any]()
            if let tempFont = otherFont {
                attributesForSecondWord[.font] = tempFont
            }
            if let tempColor = otherColor {
                attributesForSecondWord[.foregroundColor] = tempColor
            }
            if let tempBgColor = otherBgColor {
                attributesForSecondWord[.backgroundColor] = tempBgColor
            }
            result.setAttributes(attributesForSecondWord , range: (string as NSString).range(of: otherSetStr!))
        }
        
        return NSAttributedString(attributedString: result)
        
    }
    
}
