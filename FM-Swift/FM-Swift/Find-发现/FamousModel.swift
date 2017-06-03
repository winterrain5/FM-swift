//
//  FamousModel.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/17.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

class FamousModel: FindBaseModel {
    var id: Int = 0
    
    var title: String?
    
    var name: String?
    
    var displayStyle: Int = 0
    
    var list: [FamousListModel]?
}
