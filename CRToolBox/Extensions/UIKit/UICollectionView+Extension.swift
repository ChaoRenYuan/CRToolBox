//
//  UICollectionView+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

// MARK: - 基本的拓展
extension UICollectionView {
    
    /// 注册Cell
    public func cr_registerCellClass(_ cellClass: Swift.AnyClass) -> (){
        self.register(cellClass, forCellWithReuseIdentifier: NSStringFromClass(cellClass))
    }
    
    /// 拿缓存池的Cell
    public func cr_deque<T:UICollectionViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cellClass), for: indexPath) as! T
    }
    
    /// 注册HeaderFooter 默认注册elementKindSectionHeader
    public func cr_registerHeaderFooter<T:UICollectionReusableView>(viewType: T.Type, kind: String = UICollectionView.elementKindSectionHeader) -> () {
        self.register(viewType.classForCoder(), forSupplementaryViewOfKind: kind, withReuseIdentifier: NSStringFromClass(viewType))
    }
    
    /// 拿缓存池的HeaderFooter 默认拿elementKindSectionHeader
    public func cr_dequeHeaderFooter<T:UICollectionReusableView>(_ viewType: T.Type, kind: String = UICollectionView.elementKindSectionHeader, indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(viewType), for: indexPath) as! T
    }

    /**
     *    获取一个横向滚动的CollectionView
     *    需要配置delegate、dataSource、注册cell、注册headerFooter等
     */
    public class func horizontalCollectionView(configure: CollectionViewConfig) -> UICollectionView {

        //水平间隔
        let minimumInteritemSpacing: CGFloat = configure.minimumInteritemSpacing
        //垂直行间距
        let minimumLineSpacing: CGFloat = configure.minimumLineSpacing
        let height: CGFloat = configure.height
        let width: CGFloat = configure.horizontalW

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        layout.scrollDirection = .horizontal // 滚动方向
        layout.itemSize = CGSize(width: width, height: height)

        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        let tempV = UICollectionView(frame: rect, collectionViewLayout: layout)
        tempV.bounces = true
        tempV.isPagingEnabled = true
        tempV.alwaysBounceHorizontal = true
        return tempV

    }

    /// 获取一个纵向滚动的CollectionView
    public class func verticalCollectionView(frame: CGRect = CGRect.zero, configure: CollectionViewConfig) -> UICollectionView {

        //水平间隔
        let minimumInteritemSpacing: CGFloat = configure.minimumInteritemSpacing
        //垂直行间距
        let minimumLineSpacing: CGFloat = configure.minimumLineSpacing

        let width: CGFloat = configure.verticalW
        let height: CGFloat = configure.height

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        layout.scrollDirection = .vertical // 滚动方向
        layout.sectionInset = configure.sectionInset
        layout.itemSize = CGSize(width: width, height: height)

        let tempV = UICollectionView(frame: frame, collectionViewLayout: layout)
        tempV.bounces = true
        tempV.alwaysBounceVertical = true
        tempV.isPagingEnabled = true
        return tempV
    }
    
}


public struct CollectionViewConfig {
    /// 通用的ItemH 默认为60
    public var height: CGFloat = 60
    /// 横向ItemW 默认为60
    public var horizontalW: CGFloat = 60
    /// 纵向ItemH
    public var verticalW: CGFloat {
        return (customVerticalSubtractionW - (itemCount+1) * minimumInteritemSpacing) / itemCount
    }
    /// size
    public var verticalSize: CGSize {
        return CGSize(width: verticalW, height: height)
    }
    /// 自定义宽度减法
    public var customVerticalSubtractionW: CGFloat = UIScreen.main.bounds.width
    /// 水平间隔 默认为0
    public var minimumInteritemSpacing: CGFloat = 0
    /// 垂直行间距 默认为0
    public var minimumLineSpacing: CGFloat = 0
    /// 纵向每行的Item 默认为4
    public var itemCount: CGFloat = 4

    /// sectionInset的配置 默认都为0
    public var sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
}
