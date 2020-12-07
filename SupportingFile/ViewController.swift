//
//  ViewController.swift
//  CRToolBox
//
//  Created by 超人 on 2018/12/19.
//  Copyright © 2018 CR. All rights reserved.
//

import UIKit

/**
 *    MainVC
 */
class ViewController: UIViewController {
    
    // MARK: - Let
    fileprivate let rowH: CGFloat = 48
    
    // MARK: - Var
    
    // MARK: - Lazy Subviews
    fileprivate lazy var tableView: UITableView = {
        let tempV = UITableView.verticalTableView()
        tempV.rowHeight = rowH
        tempV.delegate = self
        tempV.dataSource = self
        tempV.cr_registerCellClass(UITableViewCell.self)
        return  tempV
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        createData()
        createBind()
    }
    
    // MARK: - 创造UI
    fileprivate func createUI() {
        view.addSubview(tableView)
    }
    
    // MARK: - 创造数据
    fileprivate func createData() {
        
    }
    
    // MARK: - 创造Bind
    fileprivate func createBind() {
        
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // 设置单元格内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.cr_deque(cellType: UITableViewCell.self, for: indexPath)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    // 表格单元格选中
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

// MARK: - 方法集合
extension ViewController {
    
}
