//
//  UILabel+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// 自定义UILabel初始化
    public convenience init(text: String? = nil, textColor: UIColor? = nil, font: UIFont? = nil, bgColor: UIColor? = nil) {
        
        self.init()
        //设置标题颜色
        if let color = textColor {
            self.textColor = color
        }
        // 设置文本
        if let textStr = text {
            self.text = textStr
        }
        //设置字体
        if let fontResult = font {
            self.font = fontResult
        }
        //设置背景颜色
        if let bgColorResult = bgColor {
            self.backgroundColor = bgColorResult
        }
        
    }
    
    /**
     * 富文本设置
     * @param
     *  fullStr 完整的text
     *  first* 设置第一部分的Str
     *  other* 设置其他部分的Str
     *  不设置的地方为UILabel原本的设置方法
     */
    public func customAttributedText(fullStr: String, firstSetStr: String? = nil, firstFont: UIFont? = nil, firstColor: UIColor? = nil, firstBgColor: UIColor? = nil, firstNeedSingle: Bool? = nil, otherSetStr: String? = nil, otherFont: UIFont? = nil, otherColor: UIColor? = nil, otherBgColor: UIColor? = nil) {
        
        let string = fullStr
        
        let result = NSMutableAttributedString(string: string)
        //设置iOS的字体属性
        
        if firstSetStr != nil {
            var attributesForFirstWord = [NSAttributedString.Key: Any]()
            if let tempFont = firstFont {
                attributesForFirstWord[.font] = tempFont
            }
            if let tempColor = firstColor {
                attributesForFirstWord[.foregroundColor] = tempColor
            }
            if let tempBgColor = firstBgColor {
                attributesForFirstWord[.backgroundColor] = tempBgColor
            }
            if let _ = firstNeedSingle {
                attributesForFirstWord[.underlineStyle] = NSUnderlineStyle.single
            }
            result.setAttributes(attributesForFirstWord, range:(string as NSString).range(of: firstSetStr!) )
        }
        
        
        if otherSetStr != nil {
            var attributesForSecondWord = [NSAttributedString.Key : Any]()
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
        self.attributedText = NSAttributedString(attributedString: result)
        
    }
    
    /// 根据匹配的字符串设置特殊的文本颜色、字体等
    public func cr_specialText(str: String, color: UIColor, font: UIFont) {
        let result = NSMutableAttributedString(string: self.text ?? "")
        var attributesForSecondWord = [NSAttributedString.Key : Any]()
        attributesForSecondWord[.font] = font
        attributesForSecondWord[.foregroundColor] = color
        result.setAttributes(attributesForSecondWord , range: (str as NSString).range(of: str))
        attributedText = NSAttributedString(attributedString: result)
    }
    
    /// 设置行间距
    public func cr_lineSpacing(str: String, lineSpacing: CGFloat = kLineSpacing, isMaxLayoutWidth: Bool = false) {
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineSpacing
        let attr = NSMutableAttributedString(string: str, attributes: [.paragraphStyle: paraph])
        if isMaxLayoutWidth { // 如果换行无效需要开启此句
            preferredMaxLayoutWidth = kScreenW
        }
        attributedText = attr
    }
    
    /// 设置自适应
    public func cr_adjustsFontSizeToFitWidth(minimumScaleFactor: CGFloat = 0.3) {
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = minimumScaleFactor
    }
    
}

extension UILabel {
    /// 实现复制功能
    public func enableCopyAction() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(UILabel.clickAction(ges:))))
    }
    @objc fileprivate func clickAction(ges: UIGestureRecognizer) {
        // 让其成为响应者
        becomeFirstResponder()
        // 拿出菜单控制器单例
        let menu = UIMenuController.shared
        // 创建一个复制的item
        let copy = UIMenuItem(title: "Copy", action: #selector(UILabel.copyText))
        // 将复制的item交给菜单控制器（菜单控制器其实可以接受多个操作）
        menu.menuItems = [copy]
        // 设置菜单控制器的点击区域为这个控件的bounds
        menu.setTargetRect(bounds, in: self)
        // 显示菜单控制器，默认是不可见状态
        menu.setMenuVisible(true, animated: true)
    }
    @objc public func copyText() {
        let str = text ?? ""
        CRCopyAction(str)
    }
}
