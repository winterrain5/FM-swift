//
//  FindEditorRecommendAlbum.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

class FindEditorRecommendAlbum: FindBaseModel {
    var title: String?
    
    var list: [FindFeeDetailModel]?
    
    var hasMore: Bool = false
    
    var ret: Int = 0
}
