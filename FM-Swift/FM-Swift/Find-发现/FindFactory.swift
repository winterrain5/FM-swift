//
//  FindFactory.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

enum SubFindType {
    case SubFindTypeRecommend    // 推荐
    case SubFindTypeCategory     // 分类
    case SubFindTypeRadio        // 广播
    case SubFindTypeRand         // 榜单
    case SubFindTypeAnchor       // 主播
    case SubDownloadAlbum        // 专辑
    case SubDownloadVoice        // 声音
    case SubDownloadDownloading  // 下载中
    case SubScribeRecommend      // 推荐
    case SubScribeHistory        // 历史
    case SubScribeDetail         // 订阅
    case SubFindTypeUnkown       // 未知
}

class FindFactory: NSObject {
    // MARK:- 根据标题生成对应子控制器
    class func subFindVcWith(identifier: String ) -> BaseViewController {
        let subFindType: SubFindType = typeFromTitle(identifier)
        var controller: BaseViewController!
        switch subFindType {
        case .SubFindTypeRecommend:
            controller = FindRecommandViewController()
        case .SubFindTypeCategory:
            controller = FindCategoryViewController()
        case .SubFindTypeRadio:
            controller = FindRadioViewController()
        case .SubFindTypeRand:
            controller = FindRandViewController()
        case .SubFindTypeAnchor:
            controller = FindAnchorViewController()
        case .SubDownloadAlbum:
            controller = DownAlbumViewController()
        case .SubDownloadVoice:
            controller = DownVoiceViewController()
        case .SubDownloadDownloading:
            controller = DownLoadingViewController()
        case .SubScribeDetail:
            controller = AlbumDetailViewController()
        case .SubScribeHistory:
            controller = AudioHistoryViewController()
        case .SubScribeRecommend:
            controller = SubcribeRecViewController()
        default:
            controller = BaseViewController()
        }
        return controller
    }

    
    // MARK:- 根据唯一标识符查找对应类型
    private class func typeFromTitle(_ title: String) -> SubFindType {
        if title == "推荐" {
            return .SubFindTypeRecommend
        } else if title == "分类" {
            return .SubFindTypeCategory
        } else if title == "广播" {
            return .SubFindTypeRadio
        } else if title == "榜单" {
            return .SubFindTypeRand
        } else if title == "主播" {
            return .SubFindTypeAnchor
        }else if title == "专辑" {
            return .SubDownloadAlbum
        }else if title == "声音" {
            return .SubDownloadVoice
        }else if title == "下载中" {
            return .SubDownloadDownloading
        } else if title == "推荐" {
            return .SubScribeDetail
        }else if title == "订阅" {
            return .SubScribeRecommend
        }else if title == "历史" {
            return .SubScribeHistory
        }else {
            return .SubFindTypeUnkown
        }
    }
}
