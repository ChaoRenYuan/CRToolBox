//
//  TimeInterval+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/12/7.
//  Copyright © 2020 CR. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    /// 当前的时间戳
    public static func getCurrentTimestamp() -> TimeInterval {
        let now = Date()
        let timestamp = now.timeIntervalSince1970
        return timestamp
    }
    
}
