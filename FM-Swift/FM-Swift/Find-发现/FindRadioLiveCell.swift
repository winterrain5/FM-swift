//
//  FindRadioLiveCell.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/17.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

class FindRadioLiveCell: UITableViewCell {

    // MARK:- 连线属性
    @IBOutlet weak var coverImgView: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var authorL: UILabel!
    @IBOutlet weak var usersL: UILabel!
    
    // MARK:- 定义属性
    var radioLive: RadioLocal? { didSet { setRadioLives() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension FindRadioLiveCell {
    func setRandDetailModel(detailModel: FindRandList?){
        if detailModel == nil {return}
        
        guard let result = detailModel?.firstKResults else { return }
        if result.count == 1 {
            let title = result[0].title ?? ""
            titleL.text = title
        }
        if result.count == 2 {
            let title = result[0].title ?? ""
            titleL.text = title
            let author = result[1].title ?? ""
            authorL.text = "1 \(author)"
        }
        if result.count == 3 {
            let title = result[0].title ?? ""
            titleL.text = title
            let author = result[1].title ?? ""
            authorL.text = "1 \(author)"
            let users = result[2].title ?? ""
            usersL.text = "2 \(users)"
        }

        if let imgUrl = URL(string: (detailModel?.coverPath ?? "")) {
            coverImgView.sd_setImage(with: imgUrl)
        }
    }
    
    fileprivate func setRadioLives() {
        if radioLive == nil { return }
        titleL.text = radioLive?.name
        authorL.text = "直播中: \(radioLive?.programName ?? "")"
        let countStr = getNumberAndText(with: (radioLive!.playCount))
        usersL.text = "收听人数: \(countStr)"
        if let imgUrl = URL(string: (radioLive?.coverLarge)!) {
            coverImgView.sd_setImage(with: imgUrl)
        }
    }
    
    fileprivate func getNumberAndText(with count: NSInteger) -> String {
        if count < 10000 {
            return String(format: "%ld", count)
        } else {
            return String(format: "%.1f万人", CGFloat(count) / 10000.0)
        }
    }

}
