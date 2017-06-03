//
//  RecommandViewController.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit


// MARK:- 各个section
let kFindSectionEditCommen  = 0     // 小编推荐
let kFindSectionLive        = 1     // 现场直播
let kFindSectionGuess       = 2     // 猜你喜欢
let kFindSectionCityColumn  = 3     // 城市歌单
let kFindSectionSpecial     = 4     // 精品听单
let kFindSectionAdvertise   = 5     // 推广
let kFindSectionHotCommends = 6     // 热门推荐
let kFindSectionMore        = 7     // 更多分类


// MARK:- 注册tableView的cellID
fileprivate let FindCellStyleFeeID     = "FindCellStyleFee"
fileprivate let FindCellStyleLiveID    = "FindCellStyleLive"
fileprivate let FindCellStyleSpecialID = "FindCellStyleSpecial"
fileprivate let FindCellStyleMoreID    = "FindCellStyleMore"

class FindRecommandViewController: BaseViewController {
    
    // MARK: -懒加载属性
    // viewModel
    lazy var viewModel: FindRecViewModel = {
        return FindRecViewModel()
    }()
    
    // headerView
    let headerFrame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 250)
    lazy var header: FindRecHeader = { [unowned self] in
        let header = FindRecHeader()
        header.frame = self.headerFrame
        header.layoutIfNeeded()
        return header
    }()
    
    // tableView
    lazy var tableView: UITableView = {
        let tab = UITableView(frame: self.view.frame, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.separatorStyle = .none
        tab.tableHeaderView = UIView(frame: self.headerFrame)
        tab.tableHeaderView?.addSubview(self.header)
        self.view.addSubview(tab)
        // 注册cellID
        tab.register(UINib(nibName: FindCellStyleFeeID, bundle: nil), forCellReuseIdentifier: FindCellStyleFeeID)
        tab.register(UINib(nibName: FindCellStyleLiveID, bundle: nil), forCellReuseIdentifier: FindCellStyleLiveID)
        tab.register(UINib(nibName: FindCellStyleSpecialID, bundle: nil), forCellReuseIdentifier: FindCellStyleSpecialID)
        tab.register(UINib(nibName: FindCellStyleMoreID, bundle: nil), forCellReuseIdentifier: FindCellStyleMoreID)
        return tab
    }()

    // 加载页面
    override func viewDidLoad() {
        super.viewDidLoad()
        // 加载数据
        viewModel.refreshDataSource()
        viewModel.updateBlock = {[unowned self] in
            self.header.focusImgsPics = self.viewModel.focusImgsPics
            self.header.categoryModelArr = self.viewModel.headerCategorys
            self.tableView.reloadData()
        }
        
        DLog("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DLog("viewWillAppear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        DLog("viewWillLayoutSubviews")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DLog("viewDidLayoutSubviews")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DLog("viewDidAppear")
    }
    
    // 退出页面
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    

}
extension FindRecommandViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemInSection(section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case kFindSectionEditCommen: // 小编推荐
            let editCommenCell = tableView.dequeueReusableCell(withIdentifier: FindCellStyleFeeID) as? FindCellStyleFee
            editCommenCell?.recommendModel = viewModel.editorRecAlbum
            editCommenCell?.selectionStyle = .none
            editCommenCell?.delegate = self
            return editCommenCell!
        case kFindSectionLive: // 现场直播
            let liveCell =  tableView.dequeueReusableCell(withIdentifier: FindCellStyleLiveID) as? FindCellStyleLive
            liveCell?.selectionStyle = .none
            liveCell?.liveList = viewModel.liveList as? Array<FindLive>
            liveCell?.delegate = self
            return liveCell!
        case kFindSectionGuess: // 猜你喜欢
            let guessCell = tableView.dequeueReusableCell(withIdentifier: FindCellStyleFeeID) as? FindCellStyleFee
            guessCell?.selectionStyle = .none
            guessCell?.guessModel = viewModel.guess
            return guessCell!
        case kFindSectionCityColumn: // 城市歌单
            guard viewModel.cityColumn != nil else {
                return UITableViewCell()
            }
            if viewModel.cityColumn.list?.count != 0 {
                let cityCell = tableView.dequeueReusableCell(withIdentifier: FindCellStyleFeeID) as? FindCellStyleFee
                cityCell?.selectionStyle = .none
                cityCell?.cityColumnModel = viewModel.cityColumn
                return cityCell!
            }
            return UITableViewCell()
        case kFindSectionSpecial:    // 精品听单
            guard viewModel.special != nil else {
                return UITableViewCell()
            }
            if viewModel.special.list?.count != 0 {
                let specialCell = tableView.dequeueReusableCell(withIdentifier: FindCellStyleSpecialID) as? FindCellStyleSpecial
                specialCell?.selectionStyle = .none
                specialCell?.special = viewModel.special
                specialCell?.delegate = self
                return specialCell!
            }
            return UITableViewCell()
        case kFindSectionHotCommends:    // 热门推荐
            let hotCommen = tableView.dequeueReusableCell(withIdentifier: FindCellStyleFeeID) as? FindCellStyleFee
            hotCommen?.selectionStyle = .none
            if let hotRecList = viewModel.hotRecommends.list {
                hotCommen?.hotRecommendsList = hotRecList[indexPath.row]
            }
            return hotCommen!
        case kFindSectionMore:    // 更多分类
            let moreCell = tableView.dequeueReusableCell(withIdentifier: FindCellStyleMoreID) as? FindCellStyleMore
            moreCell?.selectionStyle = .none
            return moreCell!
        default:
            return UITableViewCell()
        }
    }
    
    // cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(at: indexPath)
    }
}

// MARK: -cell代理


extension FindRecommandViewController: FindCellStyleFeeDelegate,FindCellStyleLiveDelegate,FindCellStyleSpecialDelegate {
    // MARK: 更多 -小编推荐
    func findCellStyleFeeMoreClickOn(cell: FindCellStyleFee) {
        
        let vc = FindEditRecommanViewController()
        findNaviController?.pushViewController(vc, animated: true)
        
    }
    
    //  现场直播
    func findCellStyleLiveMoreClickOn(cell: FindCellStyleLive) {
        
    }
    
    // 精品单听
    func findCellStyleSpecialMoreClickOn(cell: FindCellStyleSpecial) {
        
    }
}

