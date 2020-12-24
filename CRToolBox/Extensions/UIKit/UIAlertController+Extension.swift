//
//  UIAlertController+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    /// 模仿系统addTextField的方法
    public func cr_addCustomView(width: CGFloat = 0, height: CGFloat, action: CustomAlertTools.Action?) {
        let customView = CustomAlertTools(action: action)
        set(vc: customView, width: width, height: height)
    }
    public func set(vc: UIViewController?, width: CGFloat = 0, height: CGFloat? = nil) {
        guard let tempVC = vc else { return }
        let key = "contentViewController"
        setValue(tempVC, forKey: key)
        if let tempHeight = height {
            tempVC.preferredContentSize.height = tempHeight
            self.preferredContentSize.height = tempHeight
        }
        if width > 0 {
            tempVC.preferredContentSize.width = width
            self.preferredContentSize.width = width
        }
    }
    
}

/**
 * 自定义封装的弹框控制器
 */
@objc public class CustomAlertTools: UIViewController {
    
    public typealias Action = (_ vc: UIViewController, _ customView: UIView) -> ()
    fileprivate var action: Action?
    /***********************Variable & Lazy Loading***********************/
    @objc private lazy var customView: UIView = {
        return $0
    }(UIView())
    
    /***********************LifeCycle***********************/
    init(action: Action?) {
        super.init(nibName: nil, bundle: nil)
        self.action = action
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        view = customView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        action?(self, customView)
    }
    
    deinit {
        #if DEBUG
        let file = (#file as NSString).lastPathComponent;
        print("🤡\(file):(\(#line)) 销毁");
        #endif
    }
  
}

@objc extension UIAlertController {
    
    /// 万能present
    public func show(animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            var topRootVC = UIApplication.shared.keyWindow?.rootViewController
            while topRootVC?.presentedViewController != nil {
                topRootVC = topRootVC?.presentedViewController
            }
            topRootVC?.present(self, animated: animated, completion: completion)
        }
    }
    
    /// present
    public func alertCShow(animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: animated, completion: completion)
        }
    }
    
    /// addAction
    /// alertC.preferredAction = cancleAction;将某一个Action按钮设置粗体
    public func addAction(image: UIImage? = nil, title: String, color: UIColor? = nil, style: UIAlertAction.Style = .default, isEnabled: Bool = true, messageAlignment: NSTextAlignment = .center, handler: ((UIAlertAction) -> Void)? = nil) -> (UIAlertAction)  {
        
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        // button image
        if let image = image {
            action.setValue(image, forKey: "image")
        }
        
        // button title color
        if let color = color {
            action.setValue(color, forKey: "titleTextColor")
        }
        
        if var subVArr = self.view?.subviews { // 暂时没找到更好的方案拿 titleLbl & messageLbl 后期优化
            var tempSub = UIView()
            for _ in 0...3 {
                if let tempSubVArr = subVArr.first?.subviews {
                    subVArr = tempSubVArr
                    if let firstView = subVArr.first {
                        tempSub = firstView
                    }
                }
            }

            var titleLbl: UILabel?
            var messageLbl: UILabel?
            for obj in tempSub.subviews {
                
                if obj.isKind(of: UILabel.self) {
                    if titleLbl != nil && messageLbl == nil {
                        messageLbl = obj as? UILabel
                    }
                    if titleLbl == nil {
                        titleLbl = obj as? UILabel
                    }
                }
                
            }
            messageLbl?.lineBreakMode = .byCharWrapping
            messageLbl?.textAlignment = messageAlignment
        }
        
        
        addAction(action)
        return action
    }

    /**
     * 定义一个Action的UIAlertController
     */
    public convenience init(_ title: String? = nil, message: String? = nil, messageAlignment: NSTextAlignment = .center, needBgColor: String? = nil, style: UIAlertController.Style = .alert, cancelActionTitle: String, cancelActionColor: UIColor? = nil, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        
        self.init(title: title, message: message, preferredStyle: style)
        if needBgColor != nil { // OC中的Bool值没有Options
            
            /// 设置两个按钮的背景颜色
            if let subview = self.view.subviews.first, let alertContentView = subview.subviews.first {
                for innerView in alertContentView.subviews {
                    innerView.backgroundColor = UIColor.white
                }
            }

        }
        let _ = addAction(title: cancelActionTitle, color: cancelActionColor, style: .cancel, messageAlignment: messageAlignment, handler: cancelHandler)
        
    }
    
    
    /**
     * 定义一个Pro版的默认的UIAlertController
     */
    public convenience init(_ title: String? = nil, message: String? = nil, messageAlignment: NSTextAlignment = .center, style: UIAlertController.Style = .alert, okActionTitle: String, okActionColor: UIColor? = nil, okHandler: ((UIAlertAction) -> Void)? = nil, cancelActionTitle: String? = nil, cancelActionColor: UIColor? = nil, cancelHandler: ((UIAlertAction) -> Void)? = nil, otherActionTitle: String? = nil, otherActionColor: UIColor? = nil, otherHandler: ((UIAlertAction) -> Void)? = nil, otherActionTitle1: String? = nil, otherActionColor1: UIColor? = nil, otherHandler1: ((UIAlertAction) -> Void)? = nil) {
        
        self.init(title: title, message: message, preferredStyle: style)
        
        let _ = addAction(title: okActionTitle, color: okActionColor, style: .default, handler: okHandler)
        if cancelActionTitle != nil {
            let _ = addAction(title: cancelActionTitle ?? "", color: cancelActionColor, style: .cancel, messageAlignment: messageAlignment, handler: cancelHandler)
        }
        if otherActionTitle != nil {
            let _ = addAction(title: otherActionTitle ?? "", color: otherActionColor, style: .default, messageAlignment: messageAlignment, handler: otherHandler)
        }
        if otherActionTitle1 != nil {
            let _ = addAction(title: otherActionTitle1 ?? "", color: otherActionColor1, style: .default, messageAlignment: messageAlignment, handler: otherHandler1)
        }
    }
    
}
