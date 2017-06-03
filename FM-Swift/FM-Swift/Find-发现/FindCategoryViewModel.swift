//
//  FindCategoryModel.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/17.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON


class FindCategoryViewModel: NSObject {
    // model
    // 分类
    var categoryModel: CategoryModel?
    var discoveryColumns: FindDiscoveryColumns?
    var listArr: [CategoryList] = [CategoryList]()
    var focusImgs: FindFocusImages?
    
    // 处理数据
    // 轮播图数组
    var focusImgsPics: [String] = [String]()
    // 分类
    var  headerCategory: [FindDiscoveryColumnsList] = [FindDiscoveryColumnsList]()

    // 数据更新回调
    typealias AddBlock = () -> Void
    var  updateBlock = AddBlock?()
    
}

// MARK: -数据请求
extension FindCategoryViewModel {
    func refreshData() {
        // 加载类别中的分类 和banner下方发按钮
        CateAPI.requestCategory { [unowned self] (result, error) in
            if error != nil {
                DLog(error)
            } else {
                guard let resultData = result else {
                    return
                }
                let json = JSON(resultData)
                if let model = JSONDeserializer<CategoryModel>.deserializeFrom(json: json.description) {
                    
                    self.categoryModel = model
                    self.discoveryColumns = model.discoveryColumns
                    self.listArr = model.list!
                    self.headerCategory = (model.discoveryColumns?.list)!
                    
                    self.updateBlock?()
                }
            
            }
        }
        
        // 加载轮播图
        FindAPI.requestRecommends { (result, error) in
            guard let resultData = result else {
                return
            }
            let json = JSON(resultData)
            if let fesModel = JSONDeserializer<FindRecomendFESModel>.deserializeFrom(json: json.description) {
                
                self.focusImgs = fesModel.focusImages
                
                /// 遍历取出轮播图
                if let focusImgsList = self.focusImgs?.list {
                    for item in focusImgsList {
                        self.focusImgsPics.append(item.pic ?? "")
                    }
                }
                
                // 更新tableView数据
                self.updateBlock?()
                
            }

        }
    }
}

// MARK: -tableView数据
extension FindCategoryViewModel {
    // section
    func numberOfSection() -> NSInteger {
        let sec = self.listArr.count / 6
        let sub = self.listArr.count % 6
        return sub > 0 ? sec + 1 : sec
    }
    
    func numberOfRowsIn(section: NSInteger) -> NSInteger {
        let sec: NSInteger = self.listArr.count / 6
        if section < sec {
            return 3
        } else {
            return (self.listArr.count % 6) / 2
        }
    }
    
    // 获取每行的viewModel
    func itemModel(with indexPath: IndexPath, isLeft: Bool) -> CategoryList?{
        var index = indexPath.section * 6
        index += indexPath.row * 2
        index = isLeft ? index + 1 : index + 2  // 第一个付费精品不要,所以加1
        if listArr.count <= index {
            return nil
        }
        return listArr[index]
    }
    
    // 行高
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func heightForHeaderIn(section: NSInteger) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 10
        }
    }
    
}
