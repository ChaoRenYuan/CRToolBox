//
//  UIView+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit
import SwifterSwift

extension UIView {

    /// 倒计时
    public func cr_countDown(_ num: Int, progressBlock: @escaping (String) -> (), finishedBlock: @escaping () -> ()) {
        /// 倒计时时间
        var timeOut = num
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        timer.schedule(wallDeadline: DispatchWallTime.now(), repeating: .seconds(1))
        /// 每秒执行
        timer.setEventHandler(handler: { () -> Void in
            if timeOut <= 0 { /// 倒计时结束，关闭
                timer.cancel()
                DispatchQueue.main.sync(execute: { () -> Void in
                    if timeOut == 0 {
                        DispatchQueue.main.async {
                            finishedBlock()
                        }
                    }
                })
            } else { /// 正在倒计时
                let seconds = timeOut
                let strTime = String(format: "%lds", seconds)
                DispatchQueue.main.async {
                    progressBlock(strTime)
                }
                timeOut -= 1
            }
        })
        timer.resume()
    }

    /// 渐变色
    public func cr_gradientColor(_ colors: [CGColor], locations: [NSNumber]?, startPoint: CGPoint, endPoint: CGPoint) {
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = colors
        bgLayer1.locations = locations
        bgLayer1.frame = self.bounds
        bgLayer1.startPoint = startPoint
        bgLayer1.endPoint = endPoint
        self.layer.addSublayer(bgLayer1)
    }
    
    /// 添加圆角和阴影 radius:圆角半径 shadowOpacity: 阴影透明度 (0-1) shadowColor: 阴影颜色
    public func addRoundedAndShadow(radius: CGFloat, shadowColor: UIColor = UIColor.hexColor("#000000", alpha: 0.06), shadowRadius: CGFloat = 5, shadowOffset: CGSize = CGSize(width: 2, height: 2), shadowOpacity: Float = 1)  {
        backgroundColor = nil
        settingRoundCorner(cornerRadius: radius)
        settingShadow(shadowColor: shadowColor, shadowRadius: shadowRadius, shadowOffset: shadowOffset, shadowOpacity: shadowOpacity)
    }
    /// 设置圆角
    public func cr_settingRoundCorner(cornerRadius: CGFloat = 0) {
        let roundLayer = CAShapeLayer()
        roundLayer.fillColor = UIColor.white.cgColor
        let rect = bounds
        roundLayer.frame = rect
        var radius = cornerRadius
        if cornerRadius == 0 {
            radius = height/2
        }
        let roundPath = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        roundLayer.path = roundPath.cgPath
        layer.mask = roundLayer
        layer.addSublayer(roundLayer)
    }
    // 设置圆角
    private func settingRoundCorner(cornerRadius: CGFloat) {
        let roundLayer = CAShapeLayer()
        roundLayer.fillColor = UIColor.white.cgColor
        let rect = bounds
        roundLayer.frame = rect
        let roundPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        roundLayer.path = roundPath.cgPath
        layer.mask = roundLayer
        layer.addSublayer(roundLayer)
    }
    // 设置阴影
    private func settingShadow(shadowColor: UIColor, shadowRadius: CGFloat, shadowOffset: CGSize, shadowOpacity: Float = 1) {
        let rect = bounds
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        let path = UIBezierPath(rect: rect.offsetBy(dx: shadowOffset.width, dy: shadowOffset.height))
        layer.shadowPath = path.cgPath
    }

    fileprivate func rootView() -> UIView {
        var view = self
        while view.superview != nil {
            view = view.superview!
        }
        return view
    }
    /// 判断Rx添加数据Bind时机
    public var isOnWindow: Bool {
        return self.rootView() is UIWindow
    }

    /// 默认圆角的方法
    public func cr_roundCorners(radius: CGFloat = 0) {
        var tempR = height * 0.5
        if radius > 0 {
            tempR = radius
        }
        self.roundCorners(.allCorners, radius: tempR)
    }
}

// MARK: - 添加keywindow的操作
extension UIView {

    public class func addKeyWindowAction(_ currentView: UIView) {
        UIApplication.shared.keyWindow?.addSubview(currentView)
        currentView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            currentView.alpha = 1
        } completion: { (finished) in
            
        }
    }

    public class func removeViewAction(_ currentView: UIView) {
        if currentView.superview != nil {
            currentView.alpha = 1
            UIView.animate(withDuration: 0.3) {
                currentView.alpha = 0
            } completion: { (finished) in
                currentView.removeFromSuperview()
            }
        }
    }

    /// 设置所有子视图的背景颜色 随机颜色
    public func cr_subviewsRandomBgColor(color: UIColor = UIColor.random) {
        for v in subviews {
            v.backgroundColor = color
        }
    }

}

extension UIView {

    /// 添加外阴影
    public func cr_addShadow(ofColor: UIColor = UIColor.hexColor("#000000", alpha: 0.06), radius: CGFloat = 8, offset: CGSize = CGSize(width: 2, height: 2), opacity: Float = 1) {
        addShadow(ofColor: ofColor, radius: radius, offset: offset, opacity: opacity)
    }
}

// MARK: - 全屏
extension UIView {
    
    /// 进入全屏模式
    public func enterFullScreen() {
        if self.superview != nil {
            removeFromSuperview()
        }
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.transform = CGAffineTransform(rotationAngle: .pi / 2)
            self?.bounds = CGRect(x: 0, y: 0, width: max(UIScreen.kWidth, UIScreen.kHeight), height: min(UIScreen.kWidth, UIScreen.kHeight))
//            self?.center = CGPoint(x: self?.superview!.bounds.midX ?? 0, y: self?.superview!.bounds.midY ?? 0)
        }) { (isFinished) in
            
        }
    }


    /// 退出全屏
    public func exitFullScreen(orginalFrame: CGRect, originalSuperV: UIView) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.transform = CGAffineTransform.identity
            self?.frame = UIScreen.main.bounds
        }) { [weak self] (isFinished) in
            // 回到小屏位置
            self?.removeFromSuperview()
            self?.frame = orginalFrame
            originalSuperV.addSubview(self ?? UIView())
        }
    }
    
}
