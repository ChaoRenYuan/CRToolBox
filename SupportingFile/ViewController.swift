//
//  ViewController.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit
import ObjectMapper
import Lottie

class ViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: ------------------------ Lazy Subviews
    private lazy var loadView: LOTAnimationView = {
        let tempView = LOTAnimationView(name: "data")
        tempView.loopAnimation = true
        return tempView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "主要的VC"
        
    }
    
    private func moreTest() {
        //        self.view.backgroundColor = .orange
        TempLog("1000000000.123234320".getCurrencyFormatterWith())
        let number = NSNumber.init(value: 12345.5678)
        let reuslt = number.getSpellOut()
        TempLog(reuslt)
        
        let tempTime = "2019-01-01 00:00:00"
        let resultTime = tempTime.getUTCToLocal("yyyy-MM-dd HH:mm:ss", returnDateFormat: "yyyy-MM-dd HH:mm:ss")
        TempLog(resultTime)
    }
    
    private func objectMapperTool() {
        if ObjectMapper_CacheManagerTools.setCache(arrAndDic: ["A", "B", "C"], fileName: "test") {
            CRLog(true)
        }
        if let obj = ObjectMapper_CacheManagerTools.cacheArrAndDic(fileName: "test") {
            CRLog(obj)
        }
    }

    private func lottieTest() {
        loadView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        view.addSubview(loadView)
        loadView.play()
    }
    
    private func showAC() {
        let tempView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        tempView.layer.backgroundColor = UIColor.red.cgColor
        tempView.cr_corner(rectCorners: [.topRight , .bottomRight , .topLeft , .bottomLeft], radius: 50)
        self.view.addSubview(tempView)
        let currentTime = String.getLocalTimeWith("yyyy-MM-dd HH:mm:ss")
        TempLog(currentTime)
        let alertC = UIAlertController(title: "k", message: "a", preferredStyle: UIAlertControllerStyle.actionSheet)
        alertC.addCustomView { (vc, customView) in
            let firstStr = "aaa"
            let lastStr = "111"
            let result = firstStr + " " + lastStr
            let lbl = UILabel(text: "啊的 2", textColor: UIColor.red, size: 10)
            lbl.attributedText = UILabel.customAttributedText(fullStr: result, firstSetStr: firstStr, firstFont: UIFont.systemFont(ofSize: 36), firstColor: .orange)
            lbl.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            customView.addSubview(lbl)
        }
        alertC.show()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = TestVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
