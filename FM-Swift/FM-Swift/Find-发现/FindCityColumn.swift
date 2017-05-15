//
//  FindCityColumn.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

class FindCityColumn: FindBaseModel {
    var code: String?
    
    var title: String?
    
    var count: Int = 0
    
    var list: [FindFeeDetailModel]?
    
    var hasMore: Bool = false
    
    var contentType: String?
}
