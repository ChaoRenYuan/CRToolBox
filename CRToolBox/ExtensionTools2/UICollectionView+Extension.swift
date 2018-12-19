//
//  UICollectionView+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

extension UICollectionView{
    
    /// 注册Cell
    public func cr_registerCellClass(_ cellClass: Swift.AnyClass) -> (){
        self.register(cellClass, forCellWithReuseIdentifier: NSStringFromClass(cellClass))
    }
    
    /// 拿缓存池的Cell
    public func cr_deque<T:UICollectionViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cellClass), for: indexPath) as! T
    }
    
}
