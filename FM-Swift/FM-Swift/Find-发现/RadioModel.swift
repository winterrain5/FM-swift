//
//  RadioModel.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/18.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

class RadioModel: FindBaseModel {
    var data: RadioData?
    var ret: Int?
}

class RadioData: FindBaseModel {
    var categories: [RadioCategories]?
    var localRadios: [RadioLocal]?
    var location: String?
    var topRadios: [RadioLocal]?
}


class RadioCategories: FindBaseModel {
    var id: Int?
    var name: String?
}

class RadioLocal: FindBaseModel {
    var playUrl: RadioPlayurl?
    
    var coverSmall: String?
    
    var programName: String?
    
    var ID: Int = 0
    
    var programScheduleId: Int = 0
    
    var playCount: Int = 0
    
    var coverLarge: String?
    
    var fmUid: Int = 0
    
    var name: String?
    
    var programId: Int = 0
}

class RadioPlayurl: FindBaseModel {
    var ts64: String?
    
    var aac24: String?
    
    var aac64: String?
    
    var ts24: String?
}
