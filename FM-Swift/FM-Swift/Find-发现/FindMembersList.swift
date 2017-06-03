//
//  FindMembersList.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/16.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

class FindMembersList: FindBaseModel {
    var uid: Int?
    var titel: String?
    var subTitle: String?
    var nickname: String?
    var ownerTitle: Array<String>?
    var bannerUrl: String?
    var isAuthorizedMember: Bool?
    var memberProductId: Int?
}

/*
 {
 "uid": 29668435,
 "title": "专属语你",
 "subTitle": "陪你走过春夏秋冬，温暖你的每一个梦。 ",
 "nickname": "NJ语瞳",
 "ownerTitle": [
 "喜马签约主播",
 "百思官方主播",
 "开心一刻主播",
 "语你相伴创始"
 ],
 "bannerUrl": "http://fdfs.xmcdn.com/group20/M07/0A/70/wKgJLFd9ip6Q5YApAAO6_tJi7MQ099_mobile_x_large.jpg",
 "isAuthorizedMember": false,
 "memberProductId": 16
 }
 
 */
