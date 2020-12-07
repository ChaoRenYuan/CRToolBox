//
//  CRLable.swift
//  CRToolBox
//
//  Created by 超人 on 2019/10/20.
//

import UIKit

/**
 *    自定义Label
 */
public class CRLabel: UILabel {

    public var edgeInsets: UIEdgeInsets?
    // MARK: - init Layout
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //self.adjustsFontSizeToFitWidth = true
        //self.minimumScaleFactor = 0.3
    }
    
    /// 实现复制功能使用
    public override var canBecomeFirstResponder: Bool { return true }
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
       if action == #selector(copyText) {
           return true
       } else {
           return false
       }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 自定义内边距
    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {

        guard let insets = self.edgeInsets else {
            return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        }
        var rect = super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect

    }
    override public func drawText(in rect: CGRect) {

        guard let insets = self.edgeInsets else {
            super.drawText(in: rect)
            return
        }
        super.drawText(in: rect.inset(by: insets))
    }

}
