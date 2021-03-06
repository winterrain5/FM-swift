//
//  FindRadioSectionHeaderView.swift
//  FM
//
//  Created by  on 2016/11/20.
//  Copyright © 2016年 . All rights reserved.
//

import UIKit

enum RadioSectionHeaderViewStyle: NSInteger {
    case RadioSectionHeaderViewStyleLocal   = 0  // 本地
    case RadioSectionHeaderViewStyleTop     = 1  // 排行榜
    case RadioSectionHeaderViewStyleHistory = 2  // 历史记录
}

class FindRadioSectionHeaderView: UIView {
    
    // MARK:- 定义属性
    var style: RadioSectionHeaderViewStyle?
    var location: String?
    var model: FindRandDataDetail?

    // MARK:- 懒加载属性
    lazy var moreImgView: UIImageView = { [unowned self] in
        let img = UIImageView(image: UIImage(named: "liveRadioSectionMore_Normal"))
        self.addSubview(img)
        return img
    }()
    
    lazy var titleL: UILabel = { [unowned self] in
        let lab = UILabel()
        lab.textColor = UIColor.init(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.0)
        lab.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(lab)
        return lab
    }()
    
    lazy var iconImgView: UIImageView = { [unowned self] in
        let img = UIImageView(image: UIImage(named: "findsection_logo"))
        self.addSubview(img)
        return img
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconY = (self.height - 10.0) / 2.0
        iconImgView.frame = CGRect(x: 10, y: iconY, width: 10, height: 10)
        
        let labY = (self.height - 17.0) / 2.0
        titleL.frame = CGRect(x: 25, y: labY, width: 200, height: 17)
        
        let morY = (self.height - 12.0) / 2.0
        moreImgView.frame = CGRect(x: kScreenW - 45, y: morY, width: 35, height: 12)
    }
}

// MARK:- 自定义init
extension FindRadioSectionHeaderView {
    convenience init(style: RadioSectionHeaderViewStyle, location: String) {
        self.init(frame: CGRect.zero)
        self.style = style
        self.location = location
        configSubViews()
    }
    
    //复用而提供的自定义init
    convenience init(model: FindRandDataDetail?, showMore: Bool) {
        self.init(frame: CGRect.zero)
        self.model = model
        configSubView(with: showMore)
    }
}

// MARK:- 配置子视图
extension FindRadioSectionHeaderView {
    fileprivate func configSubViews() {
        guard let viewStyle = style else {
            return
        }
        if viewStyle == .RadioSectionHeaderViewStyleLocal {
            titleL.text = location ?? ""
        } else if viewStyle == .RadioSectionHeaderViewStyleTop {
            titleL.text = "排行榜"
        } else {
            titleL.text = "播放历史"
        }
        self.backgroundColor = UIColor.white
        layoutSubviews()
    }
}

// MARK:- 复用而提供的方法
extension FindRadioSectionHeaderView {
    fileprivate func configSubView(with showMore: Bool) {
        if model == nil {return}
        self.titleL.text = self.model?.title ?? ""
        self.moreImgView.isHidden = !showMore
        self.backgroundColor = UIColor.white
        layoutSubviews()
    }
}









