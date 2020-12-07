//
//  URL+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/1/11.
//  Copyright © 2019 CR. All rights reserved.
//

import UIKit

extension URL {
    
    /// 使用原生的方式获取网络图片的大小
    public static func getWebImgSizeWith(url: String) -> CGSize? {
        
        guard let tempURL = URL(string: url) else {return nil}
        var height: CGFloat = 0
        var width: CGFloat = 0
        do {
            let data = try Data(contentsOf: tempURL)
            
            guard let img = UIImage(data: data) else {return nil}
            
            height = img.size.height
            width = img.size.width
            let scale = height / width
            height = kScreenW * scale
            width = kScreenW
            return CGSize(width: width, height: height)
        } catch {
            return nil
        }
    }
    
    
}
