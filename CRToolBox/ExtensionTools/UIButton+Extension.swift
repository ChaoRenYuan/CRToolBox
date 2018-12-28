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
    public convenience init(title: String? = nil, titleColor: UIColor? = nil, titleFont: UIFont? = nil, titleSize: CGFloat? = nil, bgColor: UIColor? = nil, target: Any? = nil, btnSelector: Selector? = nil) {
        self.init()
        if let btnTitle = title {
            self.setTitle(btnTitle, for: .normal)
        }
        if let titleForColor = titleColor {
            self.setTitleColor(titleForColor, for: .normal)
        }
        if let font = titleFont {
            self.titleLabel?.font = font
        }
        if let size = titleSize {
            self.titleLabel?.font = UIFont.systemFont(ofSize: size)
        }
        if let btnBgColor = bgColor {
            self.backgroundColor = btnBgColor
        }
        if let btnTarget = target, let selector = btnSelector {
            self.addTarget(btnTarget, action: selector, for: .touchUpInside)
        }
        
        
    }
    
    /// 以下方法是拓展按钮中的图片和文字的位置关系
    @objc public func setPosition(image anImage: UIImage?, title: String,
                   titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState){
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    public func positionLabelRespectToImage(title: String, position: UIViewContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font ?? UIFont.systemFont(ofSize: 17)
        let titleSize = title.size(withAttributes: [NSAttributedStringKey.font: titleFont])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
    
}
