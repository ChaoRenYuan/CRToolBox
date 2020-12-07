//
//  CGFloat+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/12/7.
//  Copyright © 2020 CR. All rights reserved.
//

import UIKit

extension CGFloat {
    
    /// 适应屏幕的大小
    public var fit: CGFloat {
        if kScreenH == UIScreen.SCREEN_H_4 {
            return (CGFloat(self) * kScreenH)/(UIScreen.SCREEN_H_6)
        }
        return (CGFloat(self) * kScreenW)/(UIScreen.SCREEN_W_6)
    }
    
}
