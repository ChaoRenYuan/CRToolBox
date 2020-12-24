//
//  UITableView+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit


extension UITableView {
    
    /// 注册Cell
    public func cr_registerCellClass(_ cellClass: Swift.AnyClass) -> (){
        self.register(cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass))
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
    
    /// 注册HeaderFooter
    public func cr_registerHeaderFooterClass<T:UITableViewHeaderFooterView>(_ clazz: T.Type) -> (){
        self.register(clazz, forHeaderFooterViewReuseIdentifier: NSStringFromClass(clazz))
    }
    
    /// nib注册HeaderFooter
    public func cr_registerHeaderFooterNib<T:UITableViewHeaderFooterView>(_ clazz: T.Type) -> (){
        let nib = UINib.init(nibName: NSStringFromClass(clazz), bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: NSStringFromClass(clazz))
    }
    
    /// 拿缓存池的HeaderFooter
    public func cr_dequeHeaderFooter<T:UITableViewHeaderFooterView>(viewType: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: NSStringFromClass(viewType)) as! T
    }

}

extension UITableView {

    /// 获取一个纵向滚动的TableView
    public class func verticalTableView(frame: CGRect = CGRect.zero, style: UITableView.Style = .plain) -> UITableView {
        let tempV = UITableView(frame: frame, style: style)
        if #available(iOS 13.0, *) {
            tempV.automaticallyAdjustsScrollIndicatorInsets = false
        }
        if #available(iOS 11.0, *) {
            tempV.contentInsetAdjustmentBehavior = .never
        }
        tempV.backgroundColor = UIColor.white
        tempV.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.001))
        tempV.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.001))
        tempV.separatorStyle = .none
        tempV.separatorInset = UIEdgeInsets.zero
        //tempV.separatorColor = UIColor.nyViewColor()
        return tempV
    }
}
