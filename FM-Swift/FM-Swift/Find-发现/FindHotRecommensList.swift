//
//  FindHotRecommensList.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

class FindHotRecommensList: FindBaseModel {
    var hasMore: Bool = false
    
    var isPaid: Bool = false
    
    var contentType: String?
    
    var title: String?
    
    var isFinished: Bool = false
    
    var categoryId: Int = 0
    
    var count: Int = 0
    
    var list: [FindFeeDetailModel]?
    
    var categoryType: Int = 0
    
    var filterSupported: Bool = false
}
