//
//  Common.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/28.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

public let NC = NotificationCenter.default
public let UD = UserDefaults.standard

// MARK: - 视图相关
public let kTempH: CGFloat = 0.0001
/// 左间距 15
public let kLeft: CGFloat = 15
/// 通用上间距 20
public let kTop: CGFloat = 20
/// 通用间距 10
public let kSpace: CGFloat = 10
/// 通用边距 5
public let kMargin: CGFloat = 5
/// 通用行间距 8
public let kLineSpacing: CGFloat = 8
/// 通用提交按钮的高度 45
public let kSubmitBtnH: CGFloat = 45
/// 通用的iconSize CGSize(width: 40, height: 40)
public let kCommonIconSize = CGSize(width: 40, height: 40)
/// 动画持续的时间 0.3
public let kDurationTime: Double = 0.3
public let kListContainerViewDefaultFrame = CGRect(x: 0, y: 32, width: kScreenW, height: kScreenH - 32 - kNavigationbarH)
public let kIndicatorW: CGFloat = 15
public let kIndicatorH: CGFloat = 3
public let kHeightInTabBar: CGFloat = kScreenH-kNavigationbarH-kTabbarH-kSafeBottomH
public let kContentW: CGFloat = kScreenW - 2*kLeft

// MARK: - 服务器相关
public let kSuccessfulCodeStr = "0"
public let kSuccessfulCode = 0

// MARK: - 屏幕
/// 屏幕底部安全高度
public let kSafeBottomH: CGFloat = UIScreen.isiPhoneXMore ? 34 : 0
/// 导航栏高度
public let kNavigationbarH: CGFloat = UIScreen.isiPhoneXMore ? 88 : 64
/// 状态栏高度
public let kStatubarH: CGFloat = UIScreen.isiPhoneXMore ? 44 : 20
/// Tabbar高度
public let kTabbarH: CGFloat = 49
/// 屏幕的高（旋转屏幕有效）
public let kScreenH = UIScreen.kHeight
/// 屏幕的宽（旋转屏幕有效）
public let kScreenW = UIScreen.kWidth
/// 屏幕的Bounds
public let kScreenB = UIScreen.main.bounds
/// 通用的左边距
/// 进度条
public let kProgressBarH: CGFloat = 1

// MARK: - 分割线
/// 分割线的高度
public let kSeparatorLineH: CGFloat = 0.5
/// 分割线的宽度
public let kSeparatorLineW: CGFloat = 0.5
/// 分割块的高度
public let kSeparatorBarH: CGFloat = 10

// MARK: - 视图相关
public let kCornerRadii: CGSize = CGSize(width: 8, height: 8)

// MARK: - 分页控件配置
public let kPageHeaderInSectionH: Int = 50

// MARK: - 通用方法集合

/// 复制字符串
public func CRCopyAction(_ str: String) {
    UIPasteboard.general.string = str
}

/// 简写Image
public func CRIMG(_ imgName: String) -> UIImage? {
    return UIImage(named: imgName)
}

import SwiftyJSON
import SwifterSwift
import SwiftDate
// MARK: - 通用方法集合
/// 打印加强版
public func CRLog(_ items: Any...,
           separator: String = "\n",
           terminator: String = "\n",
           file: String = #file,
           function: String = #function,
           line: Int = #line) {
    #if DEBUG
    let filenime = (file as NSString).lastPathComponent
    let timeDate = "[\(String.getLocalTimeWith("yyyy-MM-dd HH:mm:ss"))]"
    // 还是不要太骚的打印了😂 -> print("🇨🇳开始打印:\n📆[时间]:\(timeDate)\n🗂[文件名]:[\(filenime)]\n📝[方法名]:[\(function)]\n🧮[行号]:[\(line)]")
    print("🇨🇳开始打印:\n[时间]:\(timeDate)\n[文件名]:[\(filenime)]\n[方法名]:[\(function)]\n[行号]:[\(line)]")
    print("👇🏻[打印对象的数量]:[\(items.count)]")
    var i = 0
    let j = items.count
    for item in items {
        i += 1
        print(JSON(item), terminator: (i == j ? terminator : separator))
    }
    //换行,即打印一个空行.
    print()
    #endif
}
