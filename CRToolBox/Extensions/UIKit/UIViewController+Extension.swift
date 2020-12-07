//
//  UIViewController+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2019/1/23.
//  Copyright © 2019 CR. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI
import Presentr
import ZLPhotoBrowser
import Photos

// MARK: - 基本的拓展
extension UIViewController {

    /// 自定义系统弹框 两个按钮
    /// tStr：可以添加\t符号等来修饰Message的位置
    public func cr_alertAction(_ title: String? = nil, message: String? = nil, tStr: String? = nil, messageAlignment: NSTextAlignment = .center, style: UIAlertController.Style = .alert, okTitle: String, okColor: UIColor, cancelTitle: String, cancelColor: UIColor, okBlock: (() -> Void)? = nil, cancelBlock: (() -> Void)? = nil) {

        var res = ""
        if let tempV = tStr {
            res = tempV
        }
        if let tempV = message {
            res += tempV
        }
        let alertC = UIAlertController(title, message: (message != nil) ? res : nil, messageAlignment: messageAlignment, style: style, okActionTitle: okTitle, okActionColor: okColor, okHandler: { (okAction) in
            if let block = okBlock {block()}
        }, cancelActionTitle: cancelTitle, cancelActionColor: cancelColor, cancelHandler: { (cancelAction) in
            if let block = cancelBlock {block()}
        })
        alertC.show()

    }
    
    /// 外链使用Safair打开
    public func toSafairWithUrl(_ str: String) {
        guard let url = URL(string: str) else { return }
        guard url.absoluteString.hasPrefix("http") else { return }
        let safairVC = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        if #available(iOS 11.0, *) {
            safairVC.dismissButtonStyle = .close
        }
        safairVC.preferredControlTintColor = UIColor.black
        safairVC.preferredBarTintColor = UIColor.white
        present(safairVC, animated: true, completion: nil)
    }
    
    /// 系统分享
    public func systemShareAction(title: String? = nil, img: UIImage? = nil, url: String? = nil) {
        var items = [Any]()
        if let text = title {
            items.append(text)
        }
        if let image = img {
            items.append(image)
        }
        
        if let tempUrl = url, let Url = NSURL(string: tempUrl) {
            items.append(Url)
        }
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC, animated: true) {

        }
    }
    
    /// pop指定类型控制器
    public func popToSpecialViewController(childClass: AnyClass) {
        
        var navigationController: UINavigationController?
        if isKind(of: UINavigationController.classForCoder()) {
            navigationController = self as? UINavigationController
        } else {
            navigationController = self.navigationController
        }
        guard let children = navigationController?.children else { return }
        for childVC in children {
            if childVC.isKind(of: childClass) {
                navigationController?.popToViewController(childVC, animated: true)
                break
            }
        }
    }

    func printIfViewIsOnWindow(when: String) {
        print("\(when) ==> self.view isOnWindow: \(self.view.isOnWindow)")
    }
    
    /// 通用的push
    public func pushVC(_ vc: UIViewController, animated: Bool = true) {
        if navigationController != nil {
            navigationController?.pushViewController(vc, animated: animated)
        } else {
            UIApplication.shared.visibleNC().pushViewController(vc, animated: animated)
        }
    }
    
    /// 上传图片的操作
    public func uploadImgAction(_ successfulBlock: @escaping (String, UIImage) -> Void) {
        let config = ZLPhotoConfiguration.default()
        config.maxSelectCount = 1
        let photoV = ZLPhotoPreviewSheet()
        photoV.selectImageBlock = { (images, assets, isOriginal) in
            guard let asset = assets.first else { return }
            guard let image = images.first else { return }
            let resources = PHAssetResource.assetResources(for: asset)
            var filePath = String.getLocalTimeWith(Date.ymdhmsDateFormat)
            if let fileName = resources.first?.originalFilename {
                filePath = fileName
            }
            successfulBlock(filePath, image)
        }
        photoV.showPhotoLibrary(sender: self)
    }
    
    /// Present弹窗
    public func presentCustomView(_ vc: UIViewController, width: CGFloat, height: CGFloat, duration: TimeInterval = 0.4) {
        let presenter = Presentr(presentationType: .alert)
        presenter.dismissAnimated = true
        presenter.presentationType = .custom(width: ModalSize.custom(size: Float(width)), height: ModalSize.custom(size: Float(height)), center: ModalCenterPosition.center)
        let modifiedAnimation = CrossDissolveAnimation(options: .normal(duration: duration))
        let transitionType = TransitionType.custom(modifiedAnimation)
        presenter.transitionType = transitionType
        //presenter.dismissTransitionType = transitionType 设置了也没用
        customPresentViewController(presenter, viewController: vc, animated: true)
    }
    
}

import AVKit
import SKPhotoBrowser
extension UIViewController {
    
    /// 退回上一层
    @objc public func goBackAction() {
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        } else {
            UIApplication.shared.visibleNC().popViewController(animated: true)
        }
    }

    /// 退回到指定的一层
    @objc public func goBackActionToTargetVC(vc: UIViewController) {
        if navigationController != nil {
            navigationController?.popToViewController(vc, animated: true)
        } else {
            UIApplication.shared.visibleNC().popToViewController(vc, animated: true)
        }
    }

    /// 退回到根目录VC
    @objc public func goBackRootVC() {
        if navigationController != nil {
            navigationController?.popToRootViewController(animated: true)
        } else {
            UIApplication.shared.visibleNC().popToRootViewController(animated: true)
        }
    }

    /// dismiss的动作
    @objc public func dismissBack() {
        if navigationController != nil {
            if navigationController?.viewControllers.count ?? 0 > 1 {
                navigationController?.popViewController(animated: true)
            } else {
                navigationController?.dismiss(animated: true, completion: nil)
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    /// 通用的present
    public func presentVC(_ vc: UIViewController, animated: Bool = true,
                   isNeedModalPresent: Bool = false) {
        if !isNeedModalPresent {
            vc.modalPresentationStyle = .fullScreen
        }
        present(vc, animated: animated, completion: nil)
    }

    /// 打电话
    public func callAction(phoneNumber: String) {
        guard let url = URL(string: "tel://" + phoneNumber) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    /// 预览图片
    public func previewPictures(idx: Int, imgArr: [String], animated: Bool = false) {
        var images = [SKPhoto]()
        for i in imgArr {
            let photo = SKPhoto.photoWithImageURL(i)
            photo.shouldCachePhotoURLImage = false
            images.append(photo)
        }
        SKPhotoBrowserOptions.displayAction = false
        SKPhotoBrowserOptions.displayBackAndForwardButton = true
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(idx)
        presentVC(browser, animated: animated, isNeedModalPresent: false)
    }
    
}
