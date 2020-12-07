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
    
    /// 当前时间戳(默认格式)
    public var currentTimestamp: String {
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
    public static func localTimestamp() -> TimeInterval {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let timeStamp = timeInterval
        return timeStamp
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    public static func millistamp() -> Int64 {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let millisecond = CLongLong(timeInterval*1000)
        return millisecond
    }
    
    /// 给我一个时间 返回一个时间戳和带格式的时间
    /// 例子："MM/dd EEEE"
    public static func getTimestampAndTime(_ str: String, format: String = Date.mdwDateFormat) -> ((timeStamp: TimeInterval, time: String)) {
        /// 获取开始时间
        let startdate = Date(str) ?? Date()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = format
        //时间的时间戳
        let timeInterval: TimeInterval = startdate.timeIntervalSince1970
        return (timeInterval, dformatter.string(from: startdate))
    }
    
    /// 给个时间返回一个时间戳
    public static func stringToTimeStamp(_ time: String, format: String = Date.ymdhmsDateFormat) -> TimeInterval {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format// 自定义时间格式
        guard let date = dateformatter.date(from: time) else { return 0 }
        return date.timeIntervalSince1970
    }
}
