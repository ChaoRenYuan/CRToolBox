//
//  Bundle+Extension.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// app的版本
    public static let appVersion: String = {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }()
    
}
