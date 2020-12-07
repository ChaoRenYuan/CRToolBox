//
//  String+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

// MARK: - 基本的拓展
extension String {

    /// 去除空格和换行判断字符串是否空nil
    public var isBlank: Bool {
        for character in self {
            if !character.isWhitespace {
                return false
            }
        }
        return true
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

    /// 字符尺寸
    public func stringSize(font: UIFont, w: CGFloat = CGFloat.greatestFiniteMagnitude, h: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        let strSize = (self as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin,attributes: [NSAttributedString.Key.font: font], context: nil).size
        return strSize
    }
    
    /// 多行Label的高度
    public func cr_lineSpacingHeight(numberOfLines: Int = 0, font: UIFont, width: CGFloat, lineSpacing: CGFloat = kLineSpacing) -> CGFloat {
        let tempV = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        tempV.numberOfLines = numberOfLines
        tempV.font = font
        tempV.text = self
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineSpacing
        //样式属性集合
        let attributes = [NSAttributedString.Key.paragraphStyle: paraph]
        tempV.attributedText = NSAttributedString(string: self, attributes: attributes)
        tempV.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        tempV.sizeToFit()
        return tempV.frame.height
    }
    
    /// 播放器timeInterval转时间
    public static func changeTimeFormat(_ time: CGFloat) -> String {
        if time.isNaN || time.isZero { return "" }
        let hours: Int = Int(time / 3600)
        let minutes: Int = Int(time) % 3600 / 60
        let seconds: Int = Int(time) % 60
        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
    
    /// JSON字符串转字典
    public func jsonStrToDic() -> Dictionary<String, Any> {
        guard let jsonData:Data = self.data(using: .utf8) else {return Dictionary()}
        guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? Dictionary<String, Any> else {return Dictionary()}
        return dict
    }

}

// MARK: - 正则校验字符串
extension String {

    public enum ValidateType {
        case phone
        case password
        case pureNumber
        case inviteCode
        case email
    }

    // MARK: - let
    public static let PhoneRegexString = "^1([3-9])[0-9]{9}"
    public static let PasswordRegexString = "^[A-Za-z\\d_\\.\\-\\*@#]{6,20}$"
    public static let PureNumberRegexString = "^\\d+$"
    public static let InviteCodeRegexString = "^([0-9]|[a-zA-Z]){8}$"
    public static let EmailRegexString = "^[\\w-]+[\\.\\w-]*@[\\w-]+(\\.[\\w-]{2,3})?(\\.[a-zA-Z]{2,3})$"

    // MARK: - public method
    public func validate(type: String.ValidateType) -> Bool {
        if self.isEmpty {
            return false
        }
        var regexString = ""
        switch type {
        case .phone:
            regexString = String.PhoneRegexString
        case .password:
            regexString = String.PasswordRegexString
        case .pureNumber:
            regexString = String.PureNumberRegexString
        case .inviteCode:
            regexString = String.InviteCodeRegexString
        case .email:
            regexString = String.EmailRegexString
        }
        return validate(regexString: regexString)
    }

    // MARK: - private method
    fileprivate func validate(regexString: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regexString).evaluate(with: self)
    }
}

// MARK: - 处理中英文字符 包括截取工具
extension String {

    /// 用GBK编码时的长度
    public var gbkLength: Int {
        let cfEncoding = CFStringEncodings.GB_18030_2000
        let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
        let gbkData = (self as NSString).data(using: encoding)!
        let gbkBytes = [UInt8](gbkData)
        return gbkBytes.count
    }

    /// 按GBK编码后，截取maxLen长度的字符，中文字符切不开则退避1个字节
    public func trimToGBKLength(_ maxLen: Int) -> String {
        let cfEncoding = CFStringEncodings.GB_18030_2000
        let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
        let gbkData = (self as NSString).data(using: encoding)!
        let gbkBytes = [UInt8](gbkData)
        if maxLen >= gbkBytes.count {
            return self
        } else if maxLen < 1 {
            return ""
        } else {
            if let str = NSString(data: gbkData[0..<maxLen], encoding: encoding) {
                return str as String
            } else if let str = NSString(data: gbkData[0..<maxLen - 1], encoding: encoding) {
                return str as String
            } else {
                return ""
            }
        }
    }
}

// MARK: - 针对阿里云OSS图片存储框架做自定义Resize
extension String {
    /// 针对阿里云OSS图片存储框架做自定义Resize
    public func oss_splicing(imgSize: CGSize) -> String {
        let imgW: Int = Int(imgSize.width*2) // 图片分辨率pt -> px
        let imgH: Int = Int(imgSize.height*2) // 图片分辨率pt -> px
        return self + "?x-oss-process=image/resize,w_\(imgW),h_\(imgH)"
    }
}

// MARK: - 筛选数字做颜色适配
extension String {
    /// 筛选数字做颜色适配
    public func numberChange(color: UIColor, font: UIFont,
                      regx: String = "\\d+") -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        do {
            /// 数字正则表达式
            let regexExpression = try NSRegularExpression(pattern: regx, options: NSRegularExpression.Options())
            let result = regexExpression.matches(
                in: self,
                options: NSRegularExpression.MatchingOptions(),
                range: NSMakeRange(0, count)
            )
            for item in result {
                attributeString.setAttributes(
                    [.foregroundColor : color, .font: font],
                    range: item.range
                )
            }
        } catch {
            CRLog("Failed with error: \(error)")
        }
        return attributeString
    }
    /// 特定文本做颜色适配
    public func specialText(color: UIColor, font: UIFont,
                      regx: String = "\\d+") -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        do {
            /// 数字正则表达式
            let regexExpression = try NSRegularExpression(pattern: regx, options: NSRegularExpression.Options())
            let result = regexExpression.matches(
                in: self,
                options: NSRegularExpression.MatchingOptions(),
                range: NSMakeRange(0, count)
            )
            for item in result {
                attributeString.setAttributes(
                    [.foregroundColor : color, .font: font],
                    range: item.range
                )
            }
        } catch {
            CRLog("Failed with error: \(error)")
        }
        return attributeString
    }
    
}
