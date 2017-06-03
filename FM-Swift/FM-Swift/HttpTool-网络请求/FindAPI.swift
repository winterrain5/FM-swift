//
//  FindAPI.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

// MARK:- 发现首页API
/// 小编推荐 - 轮播图 - 精品听单
fileprivate let kRecommendAPI = "http://mobile.ximalaya.com/mobile/discovery/v4/recommends?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=5.4.21"
/// 分类 - 猜你喜欢 - 听北京 - 热门推荐
fileprivate let kHotAndGuessAPI = "http://mobile.ximalaya.com/mobile/discovery/v2/recommend/hotAndGuess?code=43_110000_1100&device=iPhone&version=5.4.21"
/// 现场直播
fileprivate let kLiveRecommendAPI = "http://live.ximalaya.com/live-activity-web/v3/activity/recommend"
/// FooterAd
fileprivate let kRecomBannerAPI = "http://adse.ximalaya.com/ting?appid=0&device=iPhone&name=find_banner&network=WIFI&operator=3&scale=2&version=5.4.21"


class FindAPI: NSObject {

    
    /// 小编推荐 - 轮播图 - 精品听单
    ///
    /// - Parameter finished: <#finished description#>
    class func requestRecommends(_ finished:@escaping (_ result: AnyObject?, _ error: NSError?) -> ()) {
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kRecommendAPI, parameters: nil) { (result, error) in
            finished(result, error)
        }
    }
    
    /// 分类
    ///
    /// - Parameter finished: <#finished description#>
    class func requestHotAndGuess(_ finished:@escaping (_ result: AnyObject?, _ error: NSError?) -> ()) {
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kHotAndGuessAPI, parameters: nil) { (result, error) in
            finished(result, error)
        }
    }
    
    /// 现场直播
    ///
    /// - Parameter finished: <#finished description#>
    class func requestLiveRecommend(_ finished:@escaping (_ result: AnyObject?, _ error: NSError?) -> ()) {
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kLiveRecommendAPI, parameters: nil) { (result, error) in
            finished(result, error)
        }
    }
    
    /// FooterAd
    ///
    /// - Parameter finished: <#finished description#>
    class func requestFooterAd(_ finished:@escaping (_ result: AnyObject?, _ error: NSError?) -> ()) {
        NetworkTools.shareInstance.requestData(methodType: .GET, urlString: kRecomBannerAPI, parameters: nil) { (result, error) in
            finished(result, error)
        }
    }

    
}
