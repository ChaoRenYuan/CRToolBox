//
//  PhotoTools.swift
//  CRToolBox
//
//  Created by 超人 on 2019/1/9.
//  Copyright © 2019 CR. All rights reserved.
//

import UIKit
import SKPhotoBrowser

public extension SKPhoto {
    
    /// 添加UIImage
    public static func initImg(_ img: UIImage) -> SKPhoto {
        return SKPhoto.photoWithImage(img)
    }
    
    /// 添加网络图片
    public static func initWebImg(_ urlStr: String, holder: UIImage? = nil) -> SKPhoto {
        return SKPhoto.photoWithImageURL(urlStr, holder: holder)
    }
    
}

public extension SKLocalPhoto {
    
    /// 添加本地文件
    public static func initLocalFileImg(_ urlStr: String, holder: UIImage? = nil) -> SKLocalPhoto {
        return SKLocalPhoto.photoWithImageURL(urlStr, holder: holder)
    }
    
}
