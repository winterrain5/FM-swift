//
//  FindRandViewController.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

// MARK:- 注册tableView的cellID
fileprivate let FindRadioLiveCellID = "FindRadioLiveCell"

class FindRandViewController: BaseViewController {
    // model属性
    var focusImgs: FindFocusImages? {
        didSet{
            setFocusImgs()
        }
    }
    
    var datas: [FindRandDataDetail]? {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    // 头部视图
    let headerFrame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 160)
    lazy var headerView: FindRecHeader = {
        [unowned self] in
        let header = FindRecHeader()
        header.frame = self.headerFrame
        header.layoutIfNeeded()
        return header
    }()
    
    lazy var tableView: UITableView = {
        [unowned self] in
        let tab = UITableView(frame: self.view.frame, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.separatorStyle = .none
        tab.tableHeaderView = UIView(frame: self.headerFrame)
        tab.tableHeaderView?.addSubview(self.headerView)
        self.view.addSubview(tab)
        // 注册cellID
        tab.register(UINib(nibName: FindRadioLiveCellID, bundle: nil), forCellReuseIdentifier: FindRadioLiveCellID)
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 请求排行榜数据
        requestRankData()
    }

}

extension FindRandViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (datas?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = datas?[section]
        return data?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas?[indexPath.section]
        let detailModel = data?.list?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FindRadioLiveCellID) as? FindRadioLiveCell
        cell?.setRandDetailModel(detailModel: detailModel)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let data = datas?[section]
        let view = FindRadioSectionHeaderView(model: data, showMore: false)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
}

// MARK: -处理数据
extension FindRandViewController {
    func setFocusImgs() {
        var imgArr: [String] = [String]()
        guard let imgList = focusImgs?.list else { return }
        for img in imgList {
            imgArr.append(img.pic ?? "")
        }
        self.headerView.focusImgsPics = imgArr
    }
}

// MARK: -数据请求
extension FindRandViewController {
    func requestRankData() {
        RankAPI.requestRank { (result, error) in
            if error != nil {
                DLog(error)
            } else {
                let json = JSON(result!).description
                
                if let model = JSONDeserializer<FindRankData>.deserializeFrom(json: json) {
                    self.focusImgs = model.focusImages
                    self.datas = model.datas
                }
                
            }
        }
    }
}
