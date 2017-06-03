//
//  AppMacro.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Kingfisher

// 当前系统版本
let kCersion = (UIDevice.current.systemVersion as NSString).floatValue

// 屏幕高度
let kScreenH = UIScreen.main.bounds.height
// 屏幕宽度
let kScreenW = UIScreen.main.bounds.width

// MARK:- 颜色方法
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func DLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):(\(lineNum))-\(message)")
        
    #endif
}
