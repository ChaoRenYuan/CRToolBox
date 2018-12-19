//
//  UIColor+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// UIColor 16进制编码转换RGB
    public static func cr_hexColor(_ cr_hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var hexStr = cr_hex.uppercased()
        if (hexStr.hasPrefix("#")) {
            hexStr = (hexStr as NSString).substring(from: 1)
        }
        let scanner = Scanner(string: hexStr)
        scanner.scanLocation = 0
        var RGBValue: UInt64 = 0
        scanner.scanHexInt64(&RGBValue)
        let r = (RGBValue & 0xff0000) >> 16
        let g = (RGBValue & 0xff00) >> 8
        let b = RGBValue & 0xff
        return UIColor(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: alpha)
    }
    
    /// RGB形式转换Color
    public static func cr_rgbColor(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
}
