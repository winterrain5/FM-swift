//
//  FindRadioViewController.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

// MARK:- 注册tableView的cellID
fileprivate let FindRadioTelCellID  = "FindRadioTelCell"
fileprivate let FindRadioLiveCellID = "FindRadioLiveCell"

class FindRadioViewController: BaseViewController {

    // MARK:- 懒加载属性
    /// tableView
    lazy var tableView: UITableView = { [unowned self] in
        let tab = UITableView(frame: self.view.frame, style: .grouped)
        tab.delegate = self
        tab.dataSource = self
        tab.backgroundColor = UIColor.hexInt(0xf3f3f3)
        tab.separatorStyle = .none
        self.view.addSubview(tab)
        // 注册CellID
        tab.register(UINib(nibName: FindRadioLiveCellID, bundle: nil), forCellReuseIdentifier: FindRadioLiveCellID)
        return tab
        }()
    
    lazy var viewModel: FindRadioViewModel = {
        return FindRadioViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refreshData()
        viewModel.updateBlock = { [unowned self] in
            self.tableView.reloadData()
        }
    }

}

extension FindRadioViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == kSectionTel {   // 电台section
            var cell = tableView.dequeueReusableCell(withIdentifier: FindRadioTelCellID) as? FindRadioTelCell
            if cell == nil {
                cell = FindRadioTelCell(style: .default, reuseIdentifier: FindRadioTelCellID)
            }
            cell?.selectionStyle = .none
            cell?.viewModel = viewModel
            cell?.showMoreHandler = { [unowned self] _ in
                self.userClickShowMoreOrHiddenBtn()
            }
            return cell!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: FindRadioLiveCellID) as? FindRadioLiveCell
        var model: RadioLocal?
        if indexPath.section == kSectionTop {   // 本地section
            model = viewModel.topRadios[indexPath.row]
        } else {    // 排行榜section
            model = viewModel.localRadios[indexPath.row]
        }
        cell?.radioLive = model
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.heightForFooterIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == kSectionTel { return nil }
        let style = getSectionHeaderStyle(section: section)
        let view = FindRadioSectionHeaderView(style: style, location: viewModel.location ?? "")
        view.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 44)
        return view
    }


}

// MARK:- 通过section获取对应的headerView的style
extension FindRadioViewController {
    func getSectionHeaderStyle(section: NSInteger) -> RadioSectionHeaderViewStyle {
        switch section {
        case 1:  return .RadioSectionHeaderViewStyleLocal
        case 2: return .RadioSectionHeaderViewStyleTop
        default: return .RadioSectionHeaderViewStyleHistory
        }
    }
    func userClickShowMoreOrHiddenBtn() {
        if viewModel.style == .FindRadioTelCellStyleHidden {
            viewModel.style = .FindRadioTelCellStyleShow
        } else {
            viewModel.style = .FindRadioTelCellStyleHidden
        }
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}

