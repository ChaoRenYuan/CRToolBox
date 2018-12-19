//
//  String+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

extension String {
    
    /// 本地化字符串
    public var localized: String {
        let res = NSLocalizedString(self, comment: "")
        return (res.count > 0) ? res : self
    }
    
    /// 每个中文首字母拼接
    public func firstChineseCharacters(lowercased: Bool) -> String {
        let ostr = NSMutableString.init(string: self)
        CFStringTransform(ostr as CFMutableString, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(ostr as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
        return ostr.capitalized.components(separatedBy: " ").map { (str) -> String in
            if str.count >= 1{
                let str_f = (str as NSString).substring(to: 1)
                return lowercased ? str_f.lowercased() : str_f.uppercased()
            }
            return ""
            }.joined(separator: "")
    }
    
    /// 字符尺寸
    public func stringSize(font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
        let strSize = (self as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin,attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: font)], context: nil).size
        return strSize
    }
    
    /// 是否包含中文
    public var isContainsChinese: Bool {
        for (_, value) in self.enumerated() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    /// 根据开始位置和长度截取字符串
    public func subString(start: Int, length: Int = -1) -> String? {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
    ///判断系统选择的语言
    public static func getLanguageType() -> String {
        let def = UserDefaults.standard
        let allLanguages: [String] = def.object(forKey: "AppleLanguages") as! [String]
        let chooseLanguage = allLanguages.first
        return chooseLanguage ?? "en"
    }

}

