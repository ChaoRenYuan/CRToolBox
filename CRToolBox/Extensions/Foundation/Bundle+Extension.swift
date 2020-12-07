//
//  Bundle+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// app的版本
    public static let appVersion: String = {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }()
    
    /// iOS 获取设备当前地区的代码
    public class func preferredLanguage() -> String {
        if let str = Bundle.main.preferredLocalizations.first {return str}
        return ""
    }
    
    /// 获取Build号
    public class func build() -> String {
        if let dic = Bundle.main.infoDictionary, let str = dic["CFBundleVersion"] as? String {
             return str
        }
        return ""
    }
    
}
