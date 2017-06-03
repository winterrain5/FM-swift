//
//  FindAnchorViewController.swift
//  FM-Swift
//
//  Created by 石冬冬 on 2017/5/15.
//  Copyright © 2017年 sdd. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

// MARK:- 注册所需CellID
fileprivate let kAnchorNormalCellID = "AnchorNormalCell"
fileprivate let kAnchorSignerCellID = "AnchorSignerCell"
fileprivate let kAnchorHeaderViewID = "AnchorHeaderView"
fileprivate let kAnchorFooterViewID = "AnchorFooterView"
// MARK:- 区别header/footer
fileprivate let kSectionHeader = "UICollectionElementKindSectionHeader"
fileprivate let kSectionFooter = "UICollectionElementKindSectionFooter"

class FindAnchorViewController: BaseViewController {

    // 
    var dataSource: Array<FamousModel>? = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    /// collectionView
    lazy var collectionView: UICollectionView = { [unowned self] in
        let frame = self.view.frame
        let layout = AnchorFlowLayout()
        let col = UICollectionView(frame: frame, collectionViewLayout: layout)
        // 注册cellID
        col.register(UINib(nibName: kAnchorNormalCellID, bundle: nil), forCellWithReuseIdentifier: kAnchorNormalCellID)
        col.register(UINib(nibName: kAnchorSignerCellID, bundle: nil), forCellWithReuseIdentifier: kAnchorSignerCellID)
        // 注册headerID
        col.register(UINib(nibName: kAnchorHeaderViewID, bundle: nil), forSupplementaryViewOfKind: kSectionHeader, withReuseIdentifier: kAnchorHeaderViewID)
        // 注册footerID
        col.register(UINib(nibName: kAnchorFooterViewID, bundle: nil), forSupplementaryViewOfKind: kSectionFooter, withReuseIdentifier: kAnchorFooterViewID)
        col.delegate = self
        col.dataSource = self
        col.backgroundColor = UIColor.hexInt(0xf0f0f0)
        self.view.addSubview(col)
        return col
        }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        requsetAnchorData()
        
    }

}

extension FindAnchorViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource ,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource!.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = dataSource?[section]
        guard let list = model?.list else { return 0 }
        let count = list.count
        return count - count % 3    //保证每一行是3的倍数
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataSource?[indexPath.section]
        let modelDetail = model?.list?[indexPath.row]
        
        if model?.displayStyle == 2{    // 歌手
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAnchorSignerCellID, for: indexPath) as? AnchorSignerCell
            cell?.model = modelDetail
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAnchorNormalCellID, for: indexPath) as? AnchorNormalCell
            cell?.model = modelDetail
            return cell!
        }
    }
    
    //item size 210 x 320
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = dataSource?[indexPath.section]
        if model?.displayStyle == 2 {   // 歌手
            return CGSize(width: kScreenW, height: 90)
        }
        
        let width = kScreenW / 3.0
        let height = 32.0 * width / 21.0
        
        return CGSize(width: width, height: height)
    }
    // 设置headerView  通过kind 表示区分
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // headerView
        if kind == kSectionHeader {
            let model = dataSource?[indexPath.section]
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kSectionHeader, withReuseIdentifier: kAnchorHeaderViewID, for: indexPath) as? AnchorHeaderView
            header?.setModel(model: model)
            return header!
        } else {    // footerView
            return collectionView.dequeueReusableSupplementaryView(ofKind: kSectionFooter, withReuseIdentifier: kAnchorFooterViewID, for: indexPath)
        }
    }
    
    //footer size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: kScreenW, height: 10)
    }
    
    //header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kScreenW, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: -数据请求
extension FindAnchorViewController {
    func requsetAnchorData() {
        AnchorAPI.requestAnchorData { (result, error) in
            if error != nil {
                
            } else {
                let json = JSON(result!).description
                
                if let model = JSONDeserializer<AnchorModel>.deserializeFrom(json: json) {
                    for item in model.famous! {
                        self.dataSource?.append(item)
                    }
                    for item in model.normal! {
                        self.dataSource?.append(item)
                    }
                    
                }
            }
        }
    }
}

class AnchorFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        // 1.设置itemSize
        let width = kScreenW / 3.0
        let height = 32.0 * width / 21.0
        let size = CGSize(width: width, height: height)
        itemSize                = collectionView!.frame.size
        minimumLineSpacing      = 0             // 设置最小行间距
        minimumInteritemSpacing = 0             // 设置最小item间距
        scrollDirection         = .vertical     // 设置滚动方向
        
        // 2.设置collectionView的属性
        collectionView?.isPagingEnabled                = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator   = false

    }
}
