//
//  NetworkTools.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
import Alamofire

/// 请求类型
enum RequestType: Int {
    case GET
    case POST
}

class NetworkTools: NSObject {
    
    // 单例方法
    static let shareInstance: NetworkTools = {
        return NetworkTools()
    }()
    
    
}

// MARK: -请求方法
extension NetworkTools {
    func requestData(methodType: RequestType, urlString: String, parameters: [String: AnyObject]?, finished:@escaping (_ result: AnyObject?, _ error: NSError?) -> ()) {
        // 定义请求结果回调闭包
        let resultCallBack = { (response: DataResponse<Any>) in
            if response.result.isSuccess {
                finished(response.result.value as AnyObject?, nil)
            } else {
                finished(nil,response.result.error as NSError?)
            }
        }
        
        // 2 请求数据
        let httpMethod: HTTPMethod = methodType == .GET ? .get : .post
        request(urlString, method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: resultCallBack)
    }
}
