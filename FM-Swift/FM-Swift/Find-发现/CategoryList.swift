//
//  CategoryList.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/17.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

class CategoryList: FindBaseModel {
    var id: Int = 0
    
    var orderNum: Int = 0
    
    var filterSupported: Bool = false
    
    var isChecked: Bool = false
    
    var isFinished: Bool = false
    
    var contentType: String?
    
    var isPaid: Bool = false
    
    var title: String?
    
    var selectedSwitch: Bool = false
    
    var categoryType: Int = 0
    
    var coverPath: String?
    
    var name: String?
}
