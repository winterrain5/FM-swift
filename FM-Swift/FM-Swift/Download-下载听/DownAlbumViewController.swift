//
//  DownAlbumViewController.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/16.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class DownAlbumViewController: BaseViewController {

    // MARK:- 定义属性
    var noDataImg: UIImage!
    
    // MARK:- 懒加载属性
    lazy var tableView: UITableView = { [unowned self] in
        let tab = UITableView(frame: self.view.frame, style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.backgroundColor = UIColor.hexInt(0xf3f3f3)
        tab.tableFooterView = UIView()
        return tab
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        // 设置空视图图片
        noDataImg = UIImage(named: "noData_play_history")
        // 设置空视图状态
        configEmptStatus()
        DLog("DownAlbumViewController")
    }

  

}
// MARK:- 初始化
extension DownAlbumViewController {
    // MARK: 设置空视图状态
    func configEmptStatus() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
}

// MARK:- UITableViewDelegate & UITableViewDataSource
extension DownAlbumViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "sadf"
        return cell
    }
}
// MARK:- DZNEmptyDataSetDelegate & DZNEmptyDataSetSource
extension DownAlbumViewController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return noDataImg
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        let text = "去看看"
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), NSParagraphStyleAttributeName: paragraph, NSBackgroundColorAttributeName: UIColor.clear]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        downNaviController?.pushViewController(FindEditRecommanViewController(), animated: true)
    }
    
    
}

