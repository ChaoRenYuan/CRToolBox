//
//  Date+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import Foundation

extension Date {
    
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
    
}
