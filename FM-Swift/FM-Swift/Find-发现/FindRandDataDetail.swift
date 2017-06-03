//
//  LXFFindRandModel.swift
//  LXFFM
//
//  Created by LXF on 16/11/21
//  Copyright (c) LXF. All rights reserved.
//

import UIKit
import HandyJSON

class FindRandDataDetail: HandyJSON {

    var title: String?

    var count: Int = 0

    var list: [FindRandList]?

    var ret: Int = 0
    
    required init() {}
}
