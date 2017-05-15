//
//  FindSubTitleView.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit


let kSystemOriginColor = UIColor.init(red: 0.96, green: 0.39, blue: 0.26, alpha: 1.0)
let kSystemBlackColor = UIColor.init(red: 0.38, green: 0.39, blue: 0.40, alpha: 1.0)


protocol FindSubTitleViewDelegate: NSObjectProtocol {
    // 当前选中第index标题代理
    func findSubTitleViewDidSelected(_ titleView: FindSubTitleView, index: NSInteger, title: String)
}

class FindSubTitleView: UIView {
    
    // 代理属性
    weak var delegate: FindSubTitleViewDelegate?
    
    // MARK: -属性
    fileprivate var subTitleBtnArray:[UIButton] = [UIButton]();
    fileprivate var currentSelectedBtn: UIButton?
    
    // 标题数组
    var titleArray: [String] = []{
        didSet{
            // 配置子标题
            configSubTitles()
        }
    }
    
    // 下方发滑块指示器
    lazy var sliderView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = kSystemOriginColor
        self.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 30,height: 2))
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left).offset(5)
        })
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
    }

}

// MARK: -配置子标题
extension FindSubTitleView {
    fileprivate func configSubTitles() {
        let btnW = kScreenW / CGFloat(titleArray.count)
        
        for index in 0..<titleArray.count {
            let title = titleArray[index]
            
            let btn = UIButton()
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(kSystemBlackColor, for: .normal)
            btn.setTitleColor(kSystemOriginColor, for: .selected)
            btn.setTitleColor(kSystemOriginColor, for: .highlighted)
            btn.frame = CGRect(x: CGFloat(index) * btnW, y: 0, width: btnW, height: 38)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.adjustsImageWhenDisabled = false
            btn.addTarget(self, action: #selector(subTitleClick(_ :)), for: .touchUpInside)
            subTitleBtnArray.append(btn)
            addSubview(btn)
        }
        
        // 默认选中第一个按钮
        guard let firstBtn = subTitleBtnArray.first else {
            return
        }
        selectAtBtn(firstBtn, isFirst: true)
        
    }
    
    
    /// 当前选中的按钮
    ///
    /// - Parameters:
    ///   - btn:
    ///   - isFirst: 是否是第一个选中
    fileprivate func selectAtBtn(_ btn: UIButton, isFirst: Bool) {
        btn.isSelected = true
        currentSelectedBtn = btn
        
        // 改变滑块位置
        sliderView.snp.updateConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(btn.x + btn.width * 0.5 - 15)
        }
        
        // 如果是默认选中的不执行动画
        if !isFirst {
            UIView.animate(withDuration: 0.25, animations: { 
                [unowned self] in
                self.layoutIfNeeded()
            })
        }
        
        // 对非选中按钮取消选中状态
        unSelectedBtn(btn)
        
    }
    
    fileprivate func unSelectedBtn(_ btn: UIButton) {
        for sbtn in subTitleBtnArray {
            if sbtn == btn { // 是当前选中的按钮 不操作
                continue
            }
            sbtn.isSelected = false
        }
    }
    
    // 按钮事件
    @objc func subTitleClick(_ btn: UIButton) {
        if btn == currentSelectedBtn { // 点击的按钮还是当前选中的按钮 不操作
            return
        }
        
        // 代理回调
//        delegate? 代替了 responseToSelector
        let index = subTitleBtnArray.index(of: btn)!
        let title = btn.titleLabel?.text ?? ""
        delegate?.findSubTitleViewDidSelected(self, index: index, title: title)
        // 
        selectAtBtn(btn, isFirst: false)
    }
}

// MARK: -提供的外部方法
extension FindSubTitleView {
    func jumpToShow(at index:NSInteger) {
        if index < 0 || index >= subTitleBtnArray.count {
            return
        }
        let btn = subTitleBtnArray[index]
        selectAtBtn(btn, isFirst: false)
    }
}

