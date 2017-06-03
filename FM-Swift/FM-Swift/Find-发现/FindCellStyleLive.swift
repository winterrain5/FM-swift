//
//  FindCellStyleLive.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/16.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
import SDCycleScrollView

protocol FindCellStyleLiveDelegate:NSObjectProtocol {
    func findCellStyleLiveMoreClickOn(cell: FindCellStyleLive)
}

class FindCellStyleLive: UITableViewCell {

    weak var delegate: FindCellStyleLiveDelegate?
    
    // MARK:- 连线属性
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var peopleCountL: UILabel!
    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var subContentL: UILabel!
    
    // 模型属性
    var liveList: Array<FindLive>? {
        didSet {
            setLiveList()
        }
    }
    
    // 图片链接数组
    var urlPics: Array<String> = Array()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleL.text = "现场直播"
    }

}

extension FindCellStyleLive {
    func setLiveList() {
        _ = scrollView.subviews.map{
            $0.removeFromSuperview()
        }
        
        urlPics.removeAll()
        
        // 取出轮播图地址
        for item in liveList! {
            urlPics.append(item.coverPath ?? "")
        }
        
        let cycleView = SDCycleScrollView.init(frame: scrollView.bounds, delegate: nil, placeholderImage: nil)
        cycleView?.imageURLStringsGroup = urlPics
        scrollView.addSubview(cycleView!)
    }
}


extension FindCellStyleLive {
    @IBAction func moreBtnClick(_ sender: UIButton) {
        delegate?.findCellStyleLiveMoreClickOn(cell: self)
    }
}
