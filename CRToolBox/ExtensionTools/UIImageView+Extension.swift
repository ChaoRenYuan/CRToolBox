//
//  UIImageView+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/1/11.
//  Copyright © 2019 CR. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    /** 设置网络图片
     * @prama
     * @urlStr: 网络图片的链接
     * @placeholderImg: 占位图
     * @ignoreRequestParams: 是否忽视网络网络请求参数,默认为true
     * @completion: 拿到网络请求的回调 -> (image, NSError, CacheType, URL)
     */
    public func cr_setImgUrl(_ urlStr: String?, placeholderImg: UIImage? = nil, ignoreRequestParams: Bool? = true, completion: CompletionHandler? = nil) -> () {
        let placeholderimg = (placeholderImg != nil) ? placeholderImg! : self.image
        self.image = placeholderimg
        
        var tempUrlStr = urlStr ?? ""
        if tempUrlStr.isContainsChinese { // 判断含有中文
            tempUrlStr = (tempUrlStr as NSString).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        
        guard let url = URL(string: tempUrlStr) else { return }
        
        var customCacheKey: String?
        if ignoreRequestParams ?? true { // 部分图片地址含有`?`且`?`后面部分每次请求会变化,因此只取`?`前的部分作为缓存key
            customCacheKey = tempUrlStr.contains("?") ? tempUrlStr.components(separatedBy: "?").first : tempUrlStr
        } else {
            customCacheKey = tempUrlStr
        }
        self.kf.setImage(with: ImageResource(downloadURL: url, cacheKey: customCacheKey), placeholder: placeholderimg,
                         options: [.transition(ImageTransition.none)],
                         progressBlock: nil, completionHandler: completion)
    }
    
}

