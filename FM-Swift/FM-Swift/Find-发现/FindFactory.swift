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
        } else {
            return .SubFindTypeUnkown
        }
    }
}
