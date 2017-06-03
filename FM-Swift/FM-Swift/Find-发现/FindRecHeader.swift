//
//  FindRecHeader.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/16.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
import SDCycleScrollView

let cycleViewH: CGFloat = 150   // 播视图高度
let cateIconW: Double = 71
let cateIconH: Double = 90

class FindRecHeader: UIView {

    // MARK: -连线属性
    /// 广告轮播图
    lazy var adverScrollView: UIView = {
        let view = UIView()
        view.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: cycleViewH)
        return view
    }()
    /// 类别轮播图
    lazy var cateScrollView: UIScrollView = {
        let view = UIScrollView()
        view.frame = CGRect.init(x: 0, y: cycleViewH, width: kScreenW, height: 90)
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    // MARK: -定义属性
    /// 轮播图图片数组
    var  focusImgsPics: [String]! {
        didSet {
            setupCycleView()
        }
    }
    
    /// 分类 数组模型
    var  categoryModelArr: [FindDiscoveryColumnsList]! {
        didSet{
            setupCategorys()
        }
    }
    
    /// MARK: -初始化方法
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -布局视图
extension FindRecHeader {
    
    // 添加子视图
    func setupSubViews() {
        addSubview(adverScrollView)
        addSubview(cateScrollView)
        backgroundColor = .white
    }
    
    // 设置轮播图
    func setupCycleView() {
        // 移除所有子视图
        _ = adverScrollView.subviews.map {
            $0.removeFromSuperview()
        }
        // 添加轮播图
        let frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: cycleViewH)
        let cycleView = SDCycleScrollView.init(frame: frame, delegate: self, placeholderImage: nil)
        cycleView?.showPageControl = false
        cycleView?.imageURLStringsGroup = focusImgsPics
        adverScrollView.addSubview(cycleView!)
    }
    
    // 设置分类
    func setupCategorys() {
        // 移除所有子视图
        _ = cateScrollView.subviews.map {
            $0.removeFromSuperview()
        }
        
        let count: Double = Double(categoryModelArr.count)
        if count == 0 {
            return
        }
        
        // 添加分类
        cateScrollView.contentSize = CGSize.init(width: cateIconW * count, height: cateIconH)
        for index in 0..<categoryModelArr.count {
            let model = categoryModelArr[index]
            let iconView = FindHeaderIconView.newInstance()
            iconView?.frame = CGRect(x: Double(index) * cateIconW, y: 0, width: cateIconW, height: cateIconH)
            iconView?.model = model
            cateScrollView.addSubview(iconView!)
        }
    }
}

extension FindRecHeader: SDCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
    }
}
