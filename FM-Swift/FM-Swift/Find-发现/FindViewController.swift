//
//  FindViewController.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/12.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

class FindViewController: BaseViewController {
    
    // MARK: -属性
    // 分类标题
    lazy var subTitleArr:[String] = {
        return ["推荐", "分类", "广播", "榜单", "主播"]
    }()
    
    // 分类视图
    lazy var subTitleView: FindSubTitleView = { [unowned self] in
        let subTitleV = FindSubTitleView()
        subTitleV.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 40)
       
        self.view.addSubview(subTitleV)
        return subTitleV
    }()
    
    
    
    // 所有自控制器
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.93, alpha: 1.0)
        
        subTitleView.delegate = self
        subTitleView.titleArray = subTitleArr
        
        pageVc.view.snp.makeConstraints { (make) in
            make.top.equalTo(subTitleView.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-49)
        }
        
    }
  

}

// MARK: -FindSubTitleViewDelegate
extension FindViewController: FindSubTitleViewDelegate {
    func findSubTitleViewDidSelected(_ titleView: FindSubTitleView, index: NSInteger, title: String) {
        pageVc.setCurrentSubController(index: index)
    }
}

extension FindViewController: PageViewControllerDelegate {
    func currentSubPageController(pageViewController: PageViewController, index: NSInteger) {
        subTitleView.jumpToShow(at: index)
    }
}
