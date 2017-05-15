//
//  FindRandViewController.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

class FindRandViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel()
        label.text = "FindRandViewController"
        label.textColor = UIColor.black
        label.center = view.center
        label.width = 100
        label.height = 30
        view.addSubview(label)
    }

    
}
