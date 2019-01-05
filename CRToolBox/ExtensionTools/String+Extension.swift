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
    public func stringSize(font: UIFont, w: CGFloat, h: CGFloat) -> CGSize {
        let strSize = (self as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin,attributes: [NSAttributedStringKey.font: font], context: nil).size
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

    /** 将UTC时间转本地时间
     * @param
     * @self: 为服务器的时间：例如: "2018-12-31 12:31:00"
     * @serverDateFormat: 服务器的格式，需要对应，例如"yyyy-MM-dd HH:mm:ss"
     * @returnDateFormat: 返回的格式，根据自己想要的格式，例如："yyyy-MM-dd HH:mm:ss"
     */
    public func getUTCToLocal(_ serverDateFormat: String, returnDateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = serverDateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = returnDateFormat
        
        return dateFormatter.string(from: dt!)
    }
    
    
    /** 获取当前时间，指定为公历记法（区别佛历）
     * @param
     * @returnDateFormat: 返回的格式，根据自己想要的格式，例如："yyyy-MM-dd HH:mm:ss"
     */
    public static func getLocalTimeWith(_ returnDateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = returnDateFormat
        let locale = Locale.init(identifier: Locale.preferredLanguages[0])
        dateFormatter.locale = locale
        let locationStr = dateFormatter.string(from: Date())
        return locationStr
    }
    
    /** 货币形式输出
     * @param
     * @number: 保留位数,默认为2
     */
    public func getCurrencyFormatterWith(count: Int = 2) -> String {
        if self.isEmpty {
            return "0.00"
        }
        //保留位数
        let interceptValue = String(format: "%.\(count)f", (self as NSString).doubleValue)
        //添加分隔符
        let format = NumberFormatter()
        format.numberStyle = .decimal
        let formatValue = format.string(from: NSNumber(value: (interceptValue as NSString).doubleValue))
        return formatValue ?? ""
    }
    
}

