//
//  PageViewController.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit

// MARK: -代理
protocol PageViewControllerDelegate:NSObjectProtocol {
    func currentSubPageController(pageViewController: PageViewController,index: NSInteger)
}


class PageViewController: UIViewController {
    
    // MARK: -属性
    weak var delegate: PageViewControllerDelegate?
    // 所有自控制器
    var controllers: [UIViewController] = [UIViewController]()
    // 父控制器
    var superController: UIViewController?
    var pageVC: UIPageViewController?
    
    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - superController: 父控制器
    ///   - controllers: 所有子控制器
    init(superController: UIViewController, controllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.controllers = controllers
        self.superController = superController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化
        setup()
    }
}

// MARK:- 初始化
extension PageViewController{
    /// 初始化
    fileprivate func setup() {
        if controllers.count == 0 {return}
        
        let options: [String: Any] = [UIPageViewControllerOptionSpineLocationKey : NSNumber.init(integerLiteral: UIPageViewControllerSpineLocation.none.rawValue)]
        let page = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
        page.delegate = self
        page.dataSource = self
        page.setViewControllers([controllers.first!], direction: .forward, animated: false, completion: nil)
        page.view.frame = view.frame
        pageVC = page
        self.view.addSubview(page.view)
    }
}

// MARK: - PageViewControllerDelegate && dataSource
extension PageViewController: UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    // 前一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.index(of: viewController) else {
            return nil
        }
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        return controllers[index - 1]
    }
    
    
    // 后一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.index(of: viewController) else {return nil}
        if index == NSNotFound || index == controllers.count - 1 {
            return nil
        }
        return controllers[index + 1]
    }
    
    // 控制器数量
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    // 跳转到另一个控制器界面时
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let vc = pageViewController.viewControllers?[0] else {
            return
        }
        
        let index = controllers.index(of: vc)!
        // 回调代理
        delegate?.currentSubPageController(pageViewController: self, index: index)
    }
    
}

//MARK: -向外提供的方法
extension PageViewController {
    func setCurrentSubController(index: NSInteger) {
        pageVC?.setViewControllers([controllers[index]], direction: .forward, animated: false, completion: nil)
    }
}
