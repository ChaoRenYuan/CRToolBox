//
//  UIImageView+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/1/11.
//  Copyright © 2019 CR. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - Kingfisher拓展
extension UIImageView {

    /**
     * 设置网络图片
     * urlStr: 图片的URLStr
     * imgSize: 需要下载图片的大小，一般根据设计图传大小，不传默认设置了width: 30, height: 30
     */
    public func cr_setWebImage(_ urlStr: String, size: CGSize = CGSize(width: 30, height: 30), isCornerRadius: Bool = false, radius: CGFloat = 0) { // size根据图像定义
        let url = URL(string: urlStr)
        var cornerRadius: CGFloat = 0
        if isCornerRadius {
            if radius > 0 {
                cornerRadius = radius
            } else {
                cornerRadius = size.width * 0.5
            }
        }
        let processor = DownsamplingImageProcessor(size: size) |> RoundCornerImageProcessor(cornerRadius: cornerRadius)
        kf.indicatorType = .activity

        kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ], completionHandler:  {
                result in
                switch result {
                case .success(_):
                    //print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    break
                case .failure(let error):
                    CRLog("Job failed: \(error.localizedDescription)")
                }
            })
    }
    
}

