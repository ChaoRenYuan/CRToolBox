//
//  Date+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

extension Date {
    
    /// 时间格式
    public static let yDateFormat = "YYYY"
    public static let hmDateFormat = "HH:mm"
    public static let mdDateFormat = "MM-dd"
    public static let ymdDateFormat = "YYYY-MM-dd"
    public static let ymdhmDateFormat = "YYYY-MM-dd HH:mm"
    public static let ymdhmsDateFormat = "YYYY-MM-dd HH:mm:ss"
    public static let utcDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    public static let cnDateFormat = "yyyy年MM月dd日"
    public static let ymDateFormat = "yyyy年MM月"
    public static let mdwDateFormat = "MM-dd EEEE"
    
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
    
    /// 获取当前的时间戳
    public static func cr_getCurrentTimeInterval() -> TimeInterval {
        let now = Date()
        let timestamp = now.timeIntervalSince1970
        return timestamp
    }
    
    /// 当前时间戳(默认格式)
    public var cr_currentTimestamp: String {
        return Date.cr_dateFormatterWith(formatString: "yyyy-MM-dd HH:mm:ss.SSS").string(from: self)
    }
    
    /**
     *  自定义时间格式
     *  例子：yyyy-MM-dd HH:mm:ss.SSS
     */
    public static func cr_dateFormatterWith(formatString: String) -> DateFormatter {
        let threadDic = Thread.current.threadDictionary
        var dateFormatter = threadDic.object(forKey: formatString) as? DateFormatter
        if dateFormatter == nil {
            dateFormatter = DateFormatter.init()
            dateFormatter?.dateFormat = formatString
            threadDic.setObject(dateFormatter!, forKey: formatString as NSCopying)
        }
        return dateFormatter!
    }
    
    /// 获取当前 秒级 时间戳 - 10位
    public static func cr_localTimestamp() -> TimeInterval {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let timeStamp = timeInterval
        return timeStamp
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    public static func cr_millistamp() -> Int64 {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let millisecond = CLongLong(timeInterval*1000)
        return millisecond
    }
    
    /// 给个时间返回一个时间戳
    public static func cr_stringToTimeStamp(_ time: String, format: String = Date.ymdhmsDateFormat) -> TimeInterval {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format// 自定义时间格式
        guard let date = dateformatter.date(from: time) else { return 0 }
        return date.timeIntervalSince1970
    }
}
