//
//  TestVC.swift
//  CRToolBox
//
//  Created by 超人 on 2019/1/11.
//  Copyright © 2019 CR. All rights reserved.
//

import UIKit
//import SKPhotoBrowser

/**
 *    TestVC
 */
class TestVC: UIViewController {
    
    //MARK: ------------------------ Variables & Constants
    private let imgH: CGFloat = 200
    private let imgs = [CRIMG("img"), CRIMG("img1"), CRIMG("img")]
    private let imgURLs = ["http://pic38.nipic.com/20140304/251960_133602162000_2.jpg",
                           "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=275827667,550260107&fm=26&gp=0.jpg",
                           "http://pic38.nipic.com/20140304/251960_133602162000_2.jpg"]
    //MARK: ------------------------ Lazy Subviews
    private lazy var scrollView: UIScrollView = {
        let tempView = UIScrollView(frame: CGRect(x: 0, y: 200, width: kScreenW, height: imgH))
        tempView.isPagingEnabled = true
        return tempView
    }()
    private lazy var browserView: CRImageBrowserView = {
        let tempView = CRImageBrowserView(frame: UIScreen.main.bounds)
        guard let window = UIApplication.shared.windows.first else {return tempView}
        window.addSubview(tempView)
        return tempView
    }()
    
    //MARK: ------------------------ LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createUI()
        self.createData()
    }
    
    fileprivate func createUI() -> () {
        testImgVBrowser()
    }
    
    private func testImgVBrowser() {
//        var images = [SKPhoto]()
//        view.addSubview(scrollView)
//        for url in imgURLs {
//            let photo = SKPhoto.initWebImg(url)
//            photo.shouldCachePhotoURLImage = true
//            images.append(photo)
//        }
//        SKPhotoBrowserOptions.displayStatusbar = false
//        SKPhotoBrowserOptions.displayCounterLabel = false
//        SKPhotoBrowserOptions.displayBackAndForwardButton = false
//        SKPhotoBrowserOptions.displayAction = false
//        SKPhotoBrowserOptions.displayHorizontalScrollIndicator = false
//        let browser = SKPhotoBrowser(photos: images)
//        browser.initializePageIndex(0)
//        present(browser, animated: true, completion: nil)
        
    }
    
    @objc private func imgVTap(sender: UITapGestureRecognizer) {
//        browserView.currentIndex = sender.view?.tag ?? 0
        browserView.imgURLs = imgURLs
    }
    
    fileprivate func createData() -> () {
        
    }
    
    deinit {
        browserView.removeFromSuperview()
        TempLog("\(self.description)销毁了")
    }
    
}
