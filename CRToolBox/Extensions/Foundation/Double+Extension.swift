//
//  Double+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

extension Double {
    
    /// 适应屏幕的大小 
    public var cr_fit: CGFloat {
        if UIScreen.main.bounds.height == UIScreen.SCREEN_H_4 {
            return (CGFloat(self) * UIScreen.main.bounds.height)/(UIScreen.SCREEN_H_6)
        }
        return (CGFloat(self) * UIScreen.main.bounds.width)/(UIScreen.SCREEN_W_6)
    }
    
}
