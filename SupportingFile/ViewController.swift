//
//  ViewController.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if ObjectMapper_CacheManagerTools.setCache(arrAndDic: ["A", "B", "C"], fileName: "test") {
            CRLog(true)
        }
        if let obj = ObjectMapper_CacheManagerTools.cacheArrAndDic(fileName: "test") {
            CRLog(obj)
        }
//        self.view.backgroundColor = .orange
        TempLog("1000000000.123234320".getCurrencyFormatterWith())
        let number = NSNumber.init(value: 12345.5678)
        let reuslt = number.getSpellOut()
        TempLog(reuslt)
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


}

