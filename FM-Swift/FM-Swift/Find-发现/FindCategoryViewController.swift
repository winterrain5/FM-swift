//
//  CategoryViewController.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

fileprivate let FindCategoryCellID = "FindCategoryCell"

class FindCategoryViewController: BaseViewController {
    
    var viewModel: FindCategoryViewModel = FindCategoryViewModel()
    
    // 头部视图
    let headerFrame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 250)
    lazy var headerView: FindRecHeader = {
        [unowned self] in
        let header = FindRecHeader()
        header.frame = self.headerFrame
        header.layoutIfNeeded()
        return header
    }()
    
    // tableView
    lazy var tableView: UITableView = {
        [unowned self] in
        let tab = UITableView(frame: self.view.frame, style: .grouped)
        tab.delegate = self
        tab.dataSource = self
        tab.tableHeaderView = UIView(frame: self.headerFrame)
        tab.tableHeaderView?.addSubview(self.headerView)
        tab.separatorStyle = .none
        tab.backgroundColor = UIColor.hexInt(0xf3f3f3)
        // 注册CellID
        tab.register(UINib(nibName: FindCategoryCellID, bundle: nil), forCellReuseIdentifier: FindCategoryCellID)
        self.view.addSubview(tab)
        return tab
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.refreshData()

        viewModel.updateBlock = {  [unowned self] in
            self.tableView.reloadData()
            self.headerView.focusImgsPics = self.viewModel.focusImgsPics
            self.headerView.categoryModelArr = self.viewModel.headerCategory
        }
    }
}

extension FindCategoryViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FindCategoryCellID) as? FindCategoryCell
        cell?.leftModel = viewModel.itemModel(with: indexPath, isLeft: true)
        cell?.rightModel = viewModel.itemModel(with: indexPath, isLeft: false)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 10.0))
        view.backgroundColor = UIColor.hexInt(0xf3f3f3)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

}
