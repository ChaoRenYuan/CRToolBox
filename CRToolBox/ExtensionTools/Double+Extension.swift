//
//  Double+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

extension Double {
    
    public var fit: CGFloat {
        if kScreenH == UIScreen.SCREEN_H_4 {
            return (CGFloat(self) * kScreenH)/(UIScreen.SCREEN_H_6)
        }
        return (CGFloat(self) * kScreenW)/(UIScreen.SCREEN_W_6)
    }
    
}
