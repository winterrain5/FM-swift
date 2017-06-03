//
//  FindRadioViewModel.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/18.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

let kSectionTel   = 0   // 电台section
let kSectionLocal = 1   // 本地section
let kSectionTop   = 2   // 排行榜section


enum FindRadioTelCellStyle: NSInteger {
    case FindRadioTelCellStyleHidden = 0 // 隐藏
    case FindRadioTelCellStyleShow   = 1 // 显示
}

class FindRadioViewModel: NSObject {
    var categories: Array<RadioCategories?> = []
    var localRadios: Array<RadioLocal?> = []
    var topRadios: Array<RadioLocal?> = []
    var location: String?
    var style: FindRadioTelCellStyle = .FindRadioTelCellStyleHidden

    // 数据更新回调
    typealias AddBlock = () -> Void
    var updateBlock = AddBlock?()
}

// MARK: -网络请求
extension FindRadioViewModel {
    func refreshData() {
        RadioAPI.requestRadioRecommend { [unowned self](result, error) in
            if error != nil {
                DLog(error)
            } else {
                guard let resultData = result else {return}
                let json = JSON(resultData).description
                if let model = JSONDeserializer<RadioModel>.deserializeFrom(json: json) {
                    if let data = model.data {
                        self.categories = data.categories!
                        self.localRadios = data.localRadios!
                        self.topRadios = data.topRadios!
                        self.updateBlock?()
                    }
                    
                }
                
                
            }
        }
    }
}

// MARK: -tableView数据
extension FindRadioViewModel {
    func numberOfRowsIn(section: NSInteger) -> NSInteger {
        if section == kSectionTel { // 电台
            return 1
        } else if section == kSectionLocal {
            return localRadios.count
        } else if section == kSectionTop && topRadios.count >= 3 {
            return 3
        } else {
            return topRadios.count
        }
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        if indexPath.section == kSectionTel {
            if style == .FindRadioTelCellStyleHidden {
                return 200
            } else {
                return 293
            }
        } else {
            return 85.0
        }
    }
    
    func heightForHeaderIn(section: NSInteger) -> CGFloat {
        if section == kSectionTel {
            return 0.01
        } else {
            return 40.0
        }
    }
    
    func heightForFooterIn(section: NSInteger) -> CGFloat {
        return 10.0
    }
}
