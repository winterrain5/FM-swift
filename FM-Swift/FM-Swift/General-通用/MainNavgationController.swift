//
//  MainNavgationController.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/12.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

class MainNavgationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        // 导航栏文字样式
        let attributes = [
            NSForegroundColorAttributeName: UIColor.hexInt(0x333333),
            NSFontAttributeName: UIFont.systemFont(ofSize: 18)
        ]
        UINavigationBar.appearance().tintColor = UIColor.hexInt(0x333333);
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        // 返回按钮
        let img = UIImage.init(named: "btn_back_n")?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 18, 0, 0))
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for: .default)    // 让导航条返回键带的title消失!
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(img, for: .normal, barMetrics: .default)
    }
}
