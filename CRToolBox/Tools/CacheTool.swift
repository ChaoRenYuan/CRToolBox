//
//  CacheTool.swift
//  CRToolBox
//
//  Created by 超人 on 2020/12/24.
//  Copyright © 2020 CR. All rights reserved.
//

import UIKit
import Kingfisher

public class WQCacheTool {

    /// 通过Kingfisher获取缓存数据
    public class func cr_getKFCacheSize(_ successfulBlock: @escaping (String) -> Void) {
        ImageCache.default.calculateDiskStorageSize { (result) in
            switch result {
            case .success(let size):
                successfulBlock(bytesToString(bytes: Int(size)))
            case .failure(let error):
                debugPrint("统计图片缓存失败", error)
            }
        }
    }
    /// 通过Kingfisher清理缓存
    public class func cr_clearKFCache(_ successfulBlock: @escaping () -> Void) {
        ImageCache.default.clearCache {
            successfulBlock()
        }
    }
    /// 将缓存大小做字符串处理
    fileprivate class func bytesToString(bytes: Int) -> String {
        if bytes < 1024 { // B
            return String(format: "%d B", bytes)
        } else if bytes >= 1024 && bytes < 1024 * 1024 { // KB
            let byte = Double(bytes) / 1024
            return String(format: "%.1f KB", byte)
        } else if bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024 { // MB
            let byte = Double(bytes) / (1024 * 1024)
            return String(format: "%.2f MB", byte)
        } else { // GB
            let byte = Double(bytes) / (1024 * 1024 * 1024)
            return String(format: "%.3f GB", byte)
        }
    }

}
