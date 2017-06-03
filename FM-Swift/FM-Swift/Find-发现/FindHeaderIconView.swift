//
//  FindHeaderIconView.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/16.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
import Kingfisher

class FindHeaderIconView: UIView {

    // MARK: -连线属性
    //
    @IBOutlet weak var iconImgView: UIImageView!
   
    @IBOutlet weak var titleL: UILabel!

    var model: FindDiscoveryColumnsList! {
        didSet {
            setupModel()
        }
    }
    
    // MARK: -初始化方法
    class func newInstance() -> FindHeaderIconView? {
         return Bundle.main.loadNibNamed("FindHeaderIconView", owner: nil, options: nil)?.first as? FindHeaderIconView
    }
    
    func configWith(title: String, localImgName: String) {
        titleL.text = title
        iconImgView.image = UIImage.init(named: localImgName)
    }
}

// MARK: -处理数据
extension FindHeaderIconView{
    func setupModel() {
        if let title = model.title {
            titleL.text = title
        }
        if let imgUrl = model.coverPath {
            let url = URL.init(string: imgUrl)
            iconImgView.kf.setImage(with: url)
        }
        
    }
}


