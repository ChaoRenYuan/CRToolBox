//
//  CRImageBrowserView.swift
//  CRToolBox
//
//  Created by 超人 on 2019/1/10.
//  Copyright © 2019 CR. All rights reserved.
//

import UIKit

/** 图片放大浏览器
 * 必要的：
 * 1) 将CRImageBrowserView添加到window
 * 2) deinit时，请将CRImageBrowserView.removeFromSuperview()
 * 3) 必需设置currentIndex
 * 4) 必需的数据源 imgURLs or localImgs
 */
public class CRImageBrowserView: UIView {
    
    //MARK: ------------------------ Variables & Constants
    var width: CGFloat = 0.1
    var height: CGFloat = 0.1
    var bgColor: UIColor {
        get {
            return UIColor.black
        }
        set {
            self.backgroundColor = newValue
        }
    }
    
    var currentIndex = 0 {
        didSet {
            self.alpha = 1
            if imgURLs.count > currentIndex {
                collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
            } else if localImgs.count > currentIndex {
                collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
            }
        }
    }
    
    /// 网络图片的URL
    var imgURLs = [String]() {
        didSet {
            collectionView.reloadData()
        }
    }
    /// 拿本地图片
    var localImgs = [UIImage]() {
        didSet {
            collectionView.reloadData()
        }
    }
    fileprivate var layout: UICollectionViewFlowLayout {
        get {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize.init(width: width, height: height)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
            return layout
        } set {
            self.collectionView.setCollectionViewLayout(newValue, animated: true)
        }
    }
    
    //MARK: ------------------------ Lazy Loading
    fileprivate lazy var collectionView: UICollectionView = {
        let tempView = UICollectionView.init(frame: self.bounds, collectionViewLayout: self.layout)
        tempView.cr_registerCellClass(CRImageBrowserCell.self)
        tempView.backgroundColor = bgColor
        tempView.isPagingEnabled = true
        tempView.delegate = self
        tempView.dataSource = self
        return tempView
    }()
    
    //MARK: ------------------------ LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = bgColor
        createUI()
        // 平移下滑手势
        let downPan = UIPanGestureRecognizer.init(target: self, action: #selector(downPan(sender:)))
        addGestureRecognizer(downPan)
    }
    
    //MARK: ------------------------ 向下滑动
    @objc private func downPan(sender: UIPanGestureRecognizer) {
        // 获取滑动的位置
        let point = sender.translation(in: self)
        let panX = fabs(point.x)
        let panY = fabs(point.y)
        switch sender.state {
        case .changed:
            if panY > panX, point.y >= 0 { // 向下滑动
                let alphaz: CGFloat = (1-point.y/150)
                self.alpha = alphaz
            }
        case .ended, .cancelled:
            if panY > panX, point.y >= 0 { // 向下滑动
                self.alpha = 0
            }
        default:
            break
        }
    }
    
    deinit {
        TempLog("\(self.description)移除了")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        width = frame.size.width
        height = frame.size.height
        collectionView.frame = self.bounds
        collectionView.setCollectionViewLayout(layout, animated: true)
        if imgURLs.count > currentIndex {
            collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        } else if localImgs.count > currentIndex {
            collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        }
    }
    
    //MARK: ------------------------ Private
    private func createUI() {
        addSubview(collectionView)
    }
 
}

//MARK: - UICollectionViewDataSource
extension CRImageBrowserView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imgURLs.count > 0 {
            return imgURLs.count
        }
        return localImgs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cr_deque(cellClass: CRImageBrowserCell.self, for: indexPath)
        if imgURLs.count > 0 {
            cell.configureUI(imgUrlStr: imgURLs[indexPath.item])
        } else if localImgs.count > 0 {
            cell.configureUI(img: localImgs[indexPath.item])
        }
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate
extension CRImageBrowserView: UICollectionViewDelegate {
    
}
