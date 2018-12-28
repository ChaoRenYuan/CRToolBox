//
//  ViewController.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = .orange
        print("1000000000.123234320".getCurrencyFormatter(number: 3))
        let number = NSNumber.init(value: 12345.5678)
        let reuslt = number.getSpellOut()
        CRLog(reuslt)
        let tempView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        tempView.layer.backgroundColor = UIColor.red.cgColor
        tempView.cr_corner(rectCorners: [.topRight , .bottomRight , .topLeft , .bottomLeft], radius: 50)
        self.view.addSubview(tempView)
        let currentTime = String.getLocalTimeWith("yyyy-MM-dd HH:mm:ss")
        print(currentTime)
        
//        let alertC = UIAlertController(title: "k", message: "a", preferredStyle: UIAlertControllerStyle.actionSheet)
//        alertC.addCustomView { (vc, customView) in
//            let tempview = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//            tempview.backgroundColor = .orange
//            customView.addSubview(tempview)
//        }
//        alertC.show()
        
        
        
        
    }


}

