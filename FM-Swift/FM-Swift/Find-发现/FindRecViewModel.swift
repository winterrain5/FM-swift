//
//  FindRecViewModel.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import MJExtension

class FindRecViewModel: NSObject {

    // MARK: -model属性
    ///////////////////////////////////////////////////////////
    // 
    var fesModel: FindRecomendFESModel!
    // 小编推荐
    var editorRecAlbum: FindEditorRecommendAlbum!
    // 轮播图
    var  focusImgs: FindFocusImages!
    // 精品单听
    var special: FindSpecialColumn!
    
    ///////////////////////////////////////////////////////////
    //
    var mdgchModel: FindMDGCHModel!
    // 分类
    var discoveryColumns: FindDiscoveryColumns!
    // 猜你喜欢
    var guess: FindGuess!
    // 听北京
    var  cityColumn: FindCityColumn!
    // 热门推荐
    var hotRecommends: FindHotRecommends!
    
    //////////////////////////////////////////////////////////
    //
    var activityRecModel: FindActivityRecModel?
    // 现场直播
    var liveList: Array<FindLive?> = Array()
    
    // MARK: -处理数据的属性
    // 轮播图url数组
    var focusImgsPics: [String] = [String]()
    // 分类
    var headerCategorys: [FindDiscoveryColumnsList] = [FindDiscoveryColumnsList]()
    
    // 数据更新回调
    typealias AddBlock = () -> Void
    var  updateBlock = AddBlock?()
}

// MARK: -数据请求
extension FindRecViewModel {
    func refreshDataSource() {
        FindAPI.requestRecommends { [unowned self](result, error) in
            if (error != nil) {
                DLog(error)
            } else {
                guard let resultData = result else {
                    return
                }
                let json = JSON(resultData)
                if let fesModel = JSONDeserializer<FindRecomendFESModel>.deserializeFrom(json: json.description) {
                    self.fesModel = fesModel
                    
                    self.editorRecAlbum = fesModel.editorRecommendAlbums
                    self.focusImgs = fesModel.focusImages
                    self.special = fesModel.specialColumn
                    
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
        
        FindAPI.requestHotAndGuess { [unowned self] (result, error) in
            if error != nil {
                DLog(error)
            } else {
                guard let resultData = result else {
                    return
                }
                let json = JSON(resultData)
                if let mdgchModel = JSONDeserializer<FindMDGCHModel>.deserializeFrom(json: json.description) {
                    self.mdgchModel = mdgchModel
                    
                    self.discoveryColumns = mdgchModel.discoveryColumns
                    self.guess = mdgchModel.guess
                    self.cityColumn = mdgchModel.cityColumn
                    self.hotRecommends = mdgchModel.hotRecommends
                    
                    if let discoveryColumnList = self.discoveryColumns?.list {
                        self.headerCategorys = discoveryColumnList
                    }
                    
                    // 更新tableView数据
                    self.updateBlock?()
                }

            }
        }
        
        FindAPI.requestLiveRecommend { [unowned self] (result, error) in
            if error != nil {
                DLog(error)
            } else {
                let json = JSON(result!).description
                if let model = JSONDeserializer<FindActivityRecModel>.deserializeFrom(json: json) {
                    self.activityRecModel = model
                    
                    self.liveList = model.data!
                    // 更新tableView数据
                    self.updateBlock?()
                }
                
            }
        }
    }
}

// MARK: -各section的高度
let kSectionHeight: CGFloat = 230.0
let kSectionLiveHeight: CGFloat    = 227.0
let kSectionSpecialHeight: CGFloat = 219.0
let kSectionMoreHeight: CGFloat    = 60.0

// MARK: -tableview的数据
extension FindRecViewModel {
    func numberOfSections() -> NSInteger {
        return 8
    }
    func numberOfItemInSection(_ section: NSInteger) -> NSInteger {
        // 各值定义在 LXFFindRecommendController 下
        switch section {
        case kFindSectionEditCommen:    // 小编推荐
            return 1
        case kFindSectionLive:          // 现场直播
            return liveList.count == 0 ? 0 : 1
        case kFindSectionGuess:         // 猜你喜欢
            guard (guess != nil) else { return 0 }
            return guess.list?.count == 0 ? 0 : 1
        case kFindSectionCityColumn:    // 城市歌单
            guard (cityColumn != nil) else { return 0 }
            return cityColumn.list?.count == 0 ? 0 : 1
        case kFindSectionSpecial:       // 精品听单
            guard (special != nil) else { return 0 }
            return special.list?.count == 0 ? 0 : 1
        case kFindSectionAdvertise:     // 推广
            return 0    // 暂时未找到接口
        case kFindSectionHotCommends:   // 热门推荐
            guard (hotRecommends != nil) else { return 0 }
            return (hotRecommends.list?.count)!
        case kFindSectionMore:          // 更多分类
            return 1
        default:
            return 0
        }
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case kFindSectionEditCommen:    // 小编推荐
            return kSectionHeight
        case kFindSectionLive:          // 现场直播
            return liveList.count == 0 ? 0 : kSectionLiveHeight
        case kFindSectionGuess:         // 猜你喜欢
            guard (guess != nil) else { return 0 }
            return guess.list?.count == 0 ? 0 : kSectionHeight
        case kFindSectionCityColumn:    // 城市歌单
            guard (cityColumn != nil) else { return 0 }
            return cityColumn.list?.count == 0 ? 0 : kSectionHeight
        case kFindSectionSpecial:       // 精品听单
            guard (special != nil) else { return 0 }
            return special.list?.count == 0 ? 0 : kSectionSpecialHeight
        case kFindSectionAdvertise:     // 推广
            return 0    // 暂时未找到接口
        case kFindSectionHotCommends:   // 热门推荐
            return kSectionHeight
        case kFindSectionMore:          // 更多分类
            return kSectionMoreHeight
        default:
            return 0
        }
    }
    
    
}

class Cat: HandyJSON {
    var name: String?
    var id: String?
    
    required init() {}
}

