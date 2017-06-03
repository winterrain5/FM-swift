//
//  RadioAPI.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/18.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
let kRadioAPI = "http://live.ximalaya.com/live-web/v4/homepage?device=iPhone"

class RadioAPI: NSObject {
    class func requestRadioRecommend(_ finished:@escaping (_ result: AnyObject?, _ error: NSError?) -> ()) {
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kRadioAPI, parameters: nil) { (result, error) in
            finished(result, error)
        }
    }
}
