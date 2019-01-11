//
//  CRImageBrowserCell.swift
//  CRToolBox
//
//  Created by 超人 on 2019/1/10.
//  Copyright © 2019 CR. All rights reserved.
//

/** 函数
 * 1) abs(int i)      处理int类型的取绝对值
 * 2) fabs(double i)  处理double类型的取绝对值
 * 3) fabsf(float i)  处理float类型的取绝对值
 ***/

import UIKit

public class CRImageBrowserCell: UICollectionViewCell {
    
    //MARK: ------------------------ Variables & Constants
    let maxScale: CGFloat = 3.0 // 最大缩放倍数
    let minScale: CGFloat = 0.5 // 最小倍数
    let scaleDuration = 0.38 // 缩放动画时间
    var lastScale: CGFloat = 1.0 // 最后一次的缩放比例
    var tapOffset: CGPoint? // 双击放大偏移的 point
    fileprivate var isBackTap = false
    
    //MARK: ------------------------ Lazy Loading
    fileprivate lazy var scrollView: UIScrollView = {
        let view = UIScrollView.init(frame: self.bounds)
        view.delegate = self
        view.maximumZoomScale = maxScale
        view.contentSize = self.bounds.size
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.addSubview(self.imgView)
        return view
    }()
    fileprivate lazy var imgView: UIImageView = {
        let view = UIImageView.init(frame: self.bounds)
        return view
    }()
    
    //MARK: ------------------------ LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ------------------------ Publish
    func configureUI(img: UIImage? = nil, imgUrlStr: String? = nil) {
        // 以最短的边等比例缩小图片
        let scrollViewSize = scrollView.bounds.size
        if let tempUrlStr = imgUrlStr { // 网络图片的设置
            imgView.cr_setImgUrl(tempUrlStr, placeholderImg: CRIMG("placeholderImg")) { [weak self](tempImg, error, type, url) in
                if (error == nil) {
                    var imgWebW = tempImg?.size.width ?? 0
                    var imgWebH = tempImg?.size.height ?? 0
                    let scale = imgWebH/imgWebW
                    imgWebW = kScreenW
                    imgWebH = kScreenW * scale
                    self?.imgView.bounds = CGRect.init(x: 0, y: 0, width: imgWebW, height: imgWebH)
                }
            }
        } else { // 本地图片的设置
            guard let tempImg = img else {return}
            let imgSize = tempImg.size
            let widthScale = scrollViewSize.width / imgSize.width
            let heightScale = scrollViewSize.height / imgSize.height
            let minScale = min(widthScale, heightScale)
            imgView.bounds = CGRect.init(x: 0, y: 0, width: imgSize.width * minScale, height: imgSize.height * minScale)
            imgView.image = img
        }
        
    }
    
    //MARK: ------------------------ Private
    fileprivate func createUI() {
        
        // 单击手势
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(doubleTap(sender:)))
        singleTap.numberOfTapsRequired = 1
        addGestureRecognizer(singleTap)
        
        // 双击手势
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(doubleTap(sender:)))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        
        contentView.addSubview(scrollView)
        singleTap.require(toFail: doubleTap)

    }

    //MARK: ------------------------ 双击放大
    @objc fileprivate func doubleTap(sender: UITapGestureRecognizer) {
        
        if sender.numberOfTapsRequired == 1 {
//            singleTap() // 暂时不设置
            return
        }
        
        // 获取点击的位置
        let point = sender.location(in: self)
        // 根据点击的位置计算偏移量
        calculateOffset(tapPoint: point)
        
        if lastScale > 1 {
            lastScale = 1
            isBackTap = false
        } else {
            lastScale = maxScale
            isBackTap = true
        }
        UIView.animate(withDuration: scaleDuration) {
            self.setZoomWith(scale: self.lastScale)
        }
    }
    
    //MARK: ------------------------ 设置缩放比例
    fileprivate func setZoomWith(scale: CGFloat) {
        // 缩放比例限制（在最大最小中间）
        lastScale = max(min(scale, maxScale), minScale)
        imgView.transform = CGAffineTransform.init(scaleX: lastScale, y: lastScale)
        
        let imageW = imgView.frame.size.width
        let imageH = imgView.frame.size.height
        if lastScale > 1 {
            // 内边距是针对 scrollView 捏合缩放，图片居中设置的边距
            scrollView.contentInset = UIEdgeInsets.zero // 内边距清空
            // 修改中心点
            imgView.center = CGPoint.init(x: imageW*0.5, y: imageH*0.5)
            scrollView.contentSize = CGSize.init(width: imageW, height: imageH)
            if let offset = tapOffset {
                scrollView.contentOffset = offset
            }
        } else {
            calculateInset()
            scrollView.contentSize = CGSize.zero
        }
    }
    
    //MARK: ------------------------ 计算双击放大偏移量
    fileprivate func calculateOffset(tapPoint: CGPoint) {
        
        let viewSize = self.bounds.size
        let imgViewSize = imgView.bounds.size
        // 计算最大偏移 x y
        let maxOffsetX = imgViewSize.width * maxScale - viewSize.width
        let maxOffsetY = imgViewSize.height * maxScale - viewSize.height
        
        var tapX: CGFloat = tapPoint.x
        var tapY: CGFloat = tapPoint.y
        if imgViewSize.width == viewSize.width {
            // 将 tap superview 的 point 转换 tap 到 imageView 上的距离
            tapY = tapPoint.y - (viewSize.height - imgViewSize.height) / 2
        } else {
            tapX = tapPoint.x - (viewSize.width - imgViewSize.width) / 2
        }
        // 计算偏移量
        guard let xCenter = self.superview?.center.x else {return}
        guard let yCenter = self.superview?.center.y else {return}
        let offsetX = (tapX * maxScale - xCenter)
        let offsetY = (tapY * maxScale - yCenter)
        // 判断偏移量是否超出限制（0, maxOffset）
        let x = min(max(offsetX, 0), maxOffsetX)
        let y = min(max(offsetY, 0), maxOffsetY)
        
        tapOffset = CGPoint.init(x: x, y: y)
    }
    
    //MARK: ------------------------ 计算内边距
    fileprivate func calculateInset() {
        
        let imgViewSize = imgView.frame.size
        let scrollViewSize = scrollView.bounds.size
        // 垂直内边距
        let paddingV = imgViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imgViewSize.height) / 2 : 0
        // 水平内边距
        let paddingH = imgViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imgViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets.init(top: paddingV, left: paddingH, bottom: paddingV, right: 0)
        imgView.center = CGPoint.init(x: imgViewSize.width / 2, y: imgViewSize.height / 2)
    }
    
    // MARK: ------------------------ 单击复原
    @objc fileprivate func singleTap() {
        if isBackTap {
            UIView.animate(withDuration: scaleDuration) {
                self.setZoomWith(scale: 1.0)
            }
        } else {
            self.superview?.superview?.alpha = 0
        }
        
    }
  
}

//MARK: ------------------------ UIScrollViewDelegate
extension CRImageBrowserCell: UIScrollViewDelegate {
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // 捏合动画完成计算内边距
        calculateInset()
    }
    
}


extension CRImageBrowserCell: UIGestureRecognizerDelegate {
    
    override public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let pan = gestureRecognizer as? UIPanGestureRecognizer else{return true}
        //在指定视图的坐标系中平移手势的速度。
        let velocity = pan.velocity(in: self)
        //向上滑动，不响应手势
        if velocity.y < 0 {
            return false
        }
        //横向滑动时，不响应Pan手势
        if abs(Int(velocity.x)) > Int(velocity.y){
            return false
        }
        //向下滑动，如果图片顶部超出可视范围，不响应
        if scrollView.contentOffset.y > 0 {
            return false
        }
        return true
    }
    
}
