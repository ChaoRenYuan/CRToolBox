//
//  Array+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/11/25.
//  Copyright © 2019 超人. All rights reserved.
//

import Foundation

extension Array {
    
    /// 乱序的数组
    public func cr_shuffle() -> Array {
        var list = self
        for i in 1..<list.count {
            let index:Int = Int(arc4random()) % i
            if index != i {
                list.swapAt(i, index)
            }
        }
        return list
    }
    
    /// 根据数量取数组
    public func cr_slice(num: Int) -> [Element] {
        var tempArr = self
        if !tempArr.isEmpty {
            var count = num
            if tempArr.count < num {
                count = tempArr.count
            }
            // 一个小数点引发的命案，切记切记 之前（0...3 取的值是4个）
            tempArr = Array(tempArr[0..<count])
        }
        return tempArr
    }
    
}

extension Array where Element: Equatable {
    /// 移除某个元素
    public func cr_removing(_ obj: Element) -> [Element] {
        return filter { $0 != obj }
    }
}
