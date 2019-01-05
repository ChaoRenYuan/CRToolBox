//
//  ObjectMapper_CacheManagerTools.swift
//  CRToolBox
//
//  Created by 超人 on 2019/1/5.
//  Copyright © 2019 CR. All rights reserved.
//

import Foundation
import ObjectMapper

/// ObjectMapper做缓存的工具类
public class ObjectMapper_CacheManagerTools {
    
    /**
     * @param
     * @fileName: 指定的路径名
     */
    public class func filePath(fileName: String) -> String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        return url.appendingPathComponent(fileName)!.path
    }

    /** 存模型
     * @param:
     * @object: 想要存储的模型
     * @fileName: 指定的路径名
     * 使用时需显示声明类型
     * 例如：let a:Art = ObjectMapper_CacheManagerTools.cache(for: "cacheName")
     */
    @discardableResult
    public class func setCache(object: BaseMappable, fileName: String) -> Bool {
        return setCache(arrAndDic: object.toJSON(), fileName: fileName)
    }
    
    /** 取模型
     * @param
     * @fileName: 根据路径名取出相应的模型
     */
    public class func cache<T: BaseMappable>(fileName: String) -> T? {
        guard let jsonDict = cacheArrAndDic(fileName: fileName) as? [String: Any] else {return nil}
        return Mapper<T>().map(JSON: jsonDict)
    }
    
    /** 存数组或字典
     * @param
     * @json: 想要存储的数据，json转数组或字典
     * @fileName: 指定的路径名
     */
    @discardableResult
    public class func setCache(arrAndDic: Any, fileName: String) -> Bool {
        if let array = arrAndDic as? [Any] {
            let jsonArray = NSArray(array: array)
            return NSKeyedArchiver.archiveRootObject(jsonArray, toFile: filePath(fileName: fileName))
        } else if let dict = arrAndDic as? [String: Any] {
            let jsonDict = NSDictionary(dictionary: dict)
            return NSKeyedArchiver.archiveRootObject(jsonDict, toFile: filePath(fileName: fileName))
        } else {
            return false
        }
    }
    
    /** 取数组或字典
     * @param
     * @fileName: 指定的路径名
     */
    public class func cacheArrAndDic(fileName: String) -> Any? {
        if let jsonArray = NSKeyedUnarchiver.unarchiveObject(withFile: filePath(fileName: fileName)) as? NSArray {
            return jsonArray
        }else if let jsonDict = NSKeyedUnarchiver.unarchiveObject(withFile: filePath(fileName: fileName)) as? [String: Any] {
            return jsonDict
        }else{
            return nil
        }
    }
    
    /** 清除的操作
     * @param
     * @fileName: 指定的路径名
     */
    public class func clearCache(fileName: String) -> Bool {
        // 删除数据，运用的场景有退出登录等
        let exists = FileManager.default.fileExists(atPath: filePath(fileName: fileName))
        if exists {
            do {
                // 删除路径下存储的数据
                try FileManager.default.removeItem(atPath: filePath(fileName: fileName))
                return true
            } catch let error {
                debugPrint("error: \(error.localizedDescription)")
                return false
            }
        } else {
            return false
        }
    }
    
}
