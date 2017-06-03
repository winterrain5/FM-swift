//
//  AnchorAPI.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/17.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
let kAnchorAPI = "http://mobile.ximalaya.com/mobile/discovery/v1/anchor/recommend?device=iPhone&version=5.4.27"
class AnchorAPI: FindBaseModel {
    class func requestAnchorData(_ finished: @escaping (_ reslut: AnyObject? , _ error: NSError?)->()) {
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kAnchorAPI, parameters: nil) { (result, error) in
            finished(result, error)
        }
    }
}
