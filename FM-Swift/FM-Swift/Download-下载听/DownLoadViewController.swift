//
//  DownLoadViewController.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/16.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
// MARK:- 全局变量 - 当前navigationController
var downNaviController: UINavigationController?
class DownLoadViewController: BaseViewController {


    // MARK: -属性
    // 分类标题
    lazy var subTitleArr:[String] = {
        return ["专辑","声音","下载中"]
    }()
    
//    // 分类视图
    var subTitleView: FindSubTitleView?
    // 所有子控制器
    lazy var controllers: [BaseViewController] = { [unowned self] in
        var cons: [BaseViewController] = [BaseViewController]()
        for title in self.subTitleArr {
            let con = FindFactory.subFindVcWith(identifier: title)
            cons.append(con)
        }
        return cons
    }()
    
    // 分页控制器
    lazy var pageVc: PageViewController = { [unowned self] in
        let pageVc = PageViewController.init(superController: self, controllers: self.controllers)
        pageVc.delegate = self
        self.view.addSubview(pageVc.view)
        return pageVc
    }()
    
    // 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.93, alpha: 1.0)
        
        pageVc.view.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-49)
        }
        
        subTitleView = FindSubTitleView()
        subTitleView?.titleArray = subTitleArr
        subTitleView?.delegate = self
        subTitleView?.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 40)
        navigationItem.titleView = subTitleView
        downNaviController = navigationController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

}

// MARK: -FindSubTitleViewDelegate
extension DownLoadViewController: FindSubTitleViewDelegate {
    func findSubTitleViewDidSelected(_ titleView: FindSubTitleView, index: NSInteger, title: String) {
        pageVc.setCurrentSubController(index: index)
    }
}

extension DownLoadViewController: PageViewControllerDelegate {
    func currentSubPageController(pageViewController: PageViewController, index: NSInteger) {
        subTitleView?.jumpToShow(at: index)
    }
}
