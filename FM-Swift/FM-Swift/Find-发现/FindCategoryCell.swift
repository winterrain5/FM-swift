//
//  FindCategoryCell.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/17.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

class FindCategoryCell: UITableViewCell {

    // MARK:- 连线属性
    @IBOutlet weak var leftImgView: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightImgView: UIImageView!
    @IBOutlet weak var rightLabel: UILabel!
    
    // MARK:- 定义属性
    var leftModel: CategoryList? {
        didSet {
            setLeftModel()
        }
    }
    var rightModel: CategoryList? {
        didSet {
            setRightModel()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension FindCategoryCell {
    func setLeftModel() {
        if leftModel == nil { return }
        leftLabel.text = leftModel?.title
        if let imgPath = leftModel?.coverPath {
            leftImgView.sd_setImage(with: URL(string: imgPath))
        }
    }
    
    func setRightModel() {
        if leftModel == nil { return }
        rightLabel.text = rightModel?.title
        if let imgPath = rightModel?.coverPath {
            rightImgView.sd_setImage(with: URL(string: imgPath))
        }
    }
}
