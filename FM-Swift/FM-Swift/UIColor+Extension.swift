//
//  UIColor+Extension.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/12.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

extension UIColor {
    class func hexInt(_ hexValue:Int) -> UIColor {
        let red = ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0
        let green = ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0
        let blue = ((CGFloat)(hexValue & 0xFF)) / 255.0
        return UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
