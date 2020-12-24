//
//  CGFloat+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/12/7.
//  Copyright © 2019 CR. All rights reserved.
//

import UIKit

extension CGFloat {
    
    /// 适应屏幕的大小
    public var cr_fit: CGFloat {
        if UIScreen.main.bounds.height == UIScreen.SCREEN_H_4 {
            return (CGFloat(self) * UIScreen.main.bounds.height)/(UIScreen.SCREEN_H_6)
        }
        return (CGFloat(self) * UIScreen.main.bounds.width)/(UIScreen.SCREEN_W_6)
    }
    
}
