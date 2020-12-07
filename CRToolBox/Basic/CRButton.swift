//
//  CRButton.swift
//  CRToolBox
//
//  Created by 超人 on 2019/10/20.
//

import UIKit

/**
 *    自定义Button
 */
public class CRButton: UIButton {

    // MARK: - init Layout
    public override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var isHighlighted: Bool {
        get {
            return false
        }
        set { }
    }
    
    struct RuntimeKey {
        static let buttonKey = UnsafeRawPointer.init(bitPattern: "ButtonHitTestEdgeInsetsKey".hashValue)
    }
        
    ///需要扩充的边距
    public var hitTestEdgeInsets: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, RuntimeKey.buttonKey!) as? UIEdgeInsets ?? .zero
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.buttonKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
        
    ///是否响应
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if (hitTestEdgeInsets! == UIEdgeInsets.zero) || !isEnabled || isHidden {
            return super.point(inside: point, with: event)
        } else {
            let expandArea = self.bounds.inset(by: hitTestEdgeInsets!)
            return expandArea.contains(point)
        }
    }
        
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(point, with: event)
    }

}
