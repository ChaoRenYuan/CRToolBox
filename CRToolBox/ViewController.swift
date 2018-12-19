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
        
        self.view.backgroundColor = .orange
        
        let alertC = UIAlertController(title: "k", message: "a", preferredStyle: UIAlertControllerStyle.actionSheet)
        alertC.addCustomView { (vc, customView) in
            let tempview = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            tempview.backgroundColor = .orange
            customView.addSubview(tempview)
        }
        alertC.show()
        
    }


}

