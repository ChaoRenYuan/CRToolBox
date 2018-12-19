//
//  UITableView+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

public extension UITableView {
    
    /// 注册Cell
    public func cr_registerCellClass(_ cellClass: Swift.AnyClass) -> (){
        self.register(cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass))
    }
    
    /// 注册HeaderFooter
    public func cr_registerHeaderFooterClass<T:UITableViewHeaderFooterView>(_ clazz: T.Type) -> (){
        self.register(clazz, forHeaderFooterViewReuseIdentifier: NSStringFromClass(clazz))
    }
    
    /// Nib注册Cell
    public func cr_registerCellNib(_ cellClass: Swift.AnyClass) -> (){
        let nib = UINib.init(nibName: NSStringFromClass(cellClass), bundle: nil)
        self.register(nib, forCellReuseIdentifier: NSStringFromClass(cellClass))
    }
    
    /// 拿缓存池的Cell
    public func cr_deque<T:UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: NSStringFromClass(cellType), for: indexPath) as! T
    }
    
    /// 拿缓存池的HeaderFooter
    public func cr_dequeHeaderFooter<T:UITableViewHeaderFooterView>(viewType: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(viewType)) as! T
    }
    
}
