//
//  Common.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/28.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

/// 屏幕底部安全高度
public let kSafeBottomH: CGFloat = UIScreen.isiPhoneXMore ? 34 : 0
/// 导航栏高度
public let kNavigationbarH: CGFloat = UIScreen.isiPhoneXMore ? 88 : 64
/// 状态栏高度
public let kStatubarH: CGFloat = UIScreen.isiPhoneXMore ? 44 : 20
/// Tabbar高度
public let kTabbarH:  CGFloat = 49
/// 屏幕的高（旋转屏幕有效）
public let kScreenH = UIScreen.kHeight
/// 屏幕的宽（旋转屏幕有效）
public let kScreenW = UIScreen.kWidth


/// 自定义打印
public func CRLog<T>(_ info : T, file : String = #file, function : String = #function, line : Int = #line){
    #if DEBUG
    let fileName = ((file as NSString).lastPathComponent as NSString).deletingPathExtension
    print("\(String.getLocalTimeWith("yyyy-MM-dd HH:mm:ss")) \(fileName):\(function):(\(line)) \n 🇨🇳: \(info)")
    #endif
}

public let CRNC = NotificationCenter.default

/// 简写IMG
public func CRIMG(_ imgName: String) -> UIImage {
    return UIImage(named: imgName) ?? UIImage()
}
