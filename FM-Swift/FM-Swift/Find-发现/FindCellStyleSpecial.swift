//
//  FindCellStyleSpecial.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/16.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
protocol FindCellStyleSpecialDelegate:NSObjectProtocol {
    func findCellStyleSpecialMoreClickOn(cell: FindCellStyleSpecial)
}

class FindCellStyleSpecial: UITableViewCell {

    weak var delegate: FindCellStyleSpecialDelegate?
    
    // MARK:- 连续属性
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var iconUpImg: UIImageView!
    @IBOutlet weak var titleUpL: UILabel!
    @IBOutlet weak var subTitleUpL: UILabel!
    @IBOutlet weak var introUpL: UILabel!
    @IBOutlet weak var iconDownImg: UIImageView!
    @IBOutlet weak var titleDownL: UILabel!
    @IBOutlet weak var subTitleDownL: UILabel!
    @IBOutlet weak var introDownL: UILabel!
    
    // MARK:- 模型属性
    var special: FindSpecialColumn? {
        didSet{
            setupSpecial()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension FindCellStyleSpecial {
    func setupSpecial() {
        titleL.text = special?.title
        guard let specialList = special?.list else { return }
        for index in 0..<specialList.count {
            let model = specialList[index]
            let picUrl = URL(string: model.coverPath ?? "")
            switch index {
            case 0:
                iconUpImg.sd_setImage(with: picUrl)
                titleUpL.text = model.title
                subTitleUpL.text = model.subtitle
                introUpL.text = model.footnote
            case 1:
                iconDownImg.sd_setImage(with: picUrl)
                titleDownL.text = model.title
                subTitleDownL.text = model.subtitle
                introDownL.text = model.footnote
            default: break
            }
        }
    }
}


extension FindCellStyleSpecial {
    //  更多
    @IBAction func moreBtnClick(_ sender: UIButton) {
        delegate?.findCellStyleSpecialMoreClickOn(cell: self)
    }
}
