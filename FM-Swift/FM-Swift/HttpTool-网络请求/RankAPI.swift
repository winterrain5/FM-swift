//
//  RankAPI.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/17.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

let kRankAPI = "http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/group?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=5.4.27"

class RankAPI: NSObject {
    class func requestRank(_ finished:@escaping (_ result: AnyObject?, _ error: NSError?)->()) {
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kRankAPI, parameters: nil) { (result, error) in
            finished(result, error)
        }
    }
}
