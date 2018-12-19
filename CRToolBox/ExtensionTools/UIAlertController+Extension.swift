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
    public func addCustomView(height: CGFloat = 100, action: CRCustomAlertTools.Action?) {
        let customView = CRCustomAlertTools(action: action)
        set(vc: customView, height: height)
    }
    public func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: "contentViewController")
        if let height = height {
            vc.preferredContentSize.height = height
            self.preferredContentSize.height = height
        }
    }
    
}

/**
 * 自定义封装的弹框控制器
 */
public class CRCustomAlertTools: UIViewController {
    
    
    public typealias Action = (_ vc: UIViewController, _ customView: UIView) -> ()
    fileprivate var action: Action?
    
    
    private lazy var customView: UIView = {
        return $0
    }(UIView())
    
    
    init(action: Action?) {
        super.init(nibName: nil, bundle: nil)
        self.action = action
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    override public func loadView() {
        view = customView
    }
    
}

extension UIAlertController {
    
    /// present
    public func show(animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: animated, completion: completion)
        }
    }
    
    /// addAction
    public func addAction(image: UIImage? = nil, title: String, color: UIColor? = nil, style: UIAlertActionStyle = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) {
        
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
        
        addAction(action)
    }
    
    /**
     * 定义一个默认的UIAlertController
     */
    convenience init(_ title: String? = nil, message: String? = nil, style: UIAlertControllerStyle = .alert, okActionTitle: String, okActionColor: UIColor? = nil, okHandler: ((UIAlertAction) -> Void)? = nil, cancleActionTitle: String? = nil, cancleActionColor: UIColor? = nil, cancleHandler: ((UIAlertAction) -> Void)? = nil, otherActionTitle: String? = nil, otherActionColor: UIColor? = nil, otherHandler: ((UIAlertAction) -> Void)? = nil, otherActionTitle1: String? = nil, otherActionColor1: UIColor? = nil, otherHandler1: ((UIAlertAction) -> Void)? = nil) {
        
        self.init(title: title, message: message, preferredStyle: style)
        
        addAction(title: okActionTitle, color: okActionColor, style: .default, handler: okHandler)
        cancleActionTitle == nil ? () : addAction(title: cancleActionTitle ?? "", color: cancleActionColor, style: .cancel, handler: cancleHandler)
        otherActionTitle == nil ? () : addAction(title: otherActionTitle ?? "", color: otherActionColor, style: .default, handler: otherHandler)
        otherActionTitle1 == nil ? () : addAction(title: otherActionTitle1 ?? "", color: otherActionColor1, style: .default, handler: otherHandler1)
    }
    
}
