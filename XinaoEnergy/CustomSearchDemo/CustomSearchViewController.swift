//
//  CustomSearchViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/9/10.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class CustomSearchViewController: UISearchController {

    
    lazy var hasFindCancelBtn: Bool = {
        return false
    }()
    lazy var link: CADisplayLink = {
        CADisplayLink(target: self, selector: #selector(findCancel))
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("initNib")
    }
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        print("initsearchres")
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("initcode")
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
//        searchBar.barTintColor = UIColor.red
        
        // 搜索框
        searchBar.barStyle = .default
//        self.searchBar.sizeToFit()
//        searchBar.tintColor = kLXFSearchTintColor
        // 去除上下两条横线
//        searchBar.setBackgroundImage(kSectionColor.trans2Image(), for: .any, barMetrics: .default)
        // 右侧语音
        searchBar.showsBookmarkButton = true
//        searchBar.setImage(#imageLiteral(resourceName: "Group 32@3x.png"), for: .bookmark, state: .normal)
        
        searchBar.delegate = self
        
    }
    
    @objc func findCancel() {
        let btn = searchBar.value(forKey: "_cancelButton") as AnyObject
        if btn.isKind(of: NSClassFromString("UINavigationButton")!) {
//            LXFLog("就是它")
            link.invalidate()
            link.remove(from: RunLoop.current, forMode: .commonModes)
            hasFindCancelBtn = true
            let cancel = btn as! UIButton
//            cancel.setTitleColor(kLXFSearchTintColor, for: .normal)
             cancel.setTitleColor(UIColor.orange, for: .highlighted)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置状态栏颜色
        UIApplication.shared.statusBarStyle = .default
    }
}
extension CustomSearchViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
    }
    
}
extension CustomSearchViewController: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
//        LXFLog("点击了语音按钮")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        if !hasFindCancelBtn {
//            link.add(to: RunLoop.current, forMode: .commonModes)
//        }
    }
}
extension CustomSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
    }
}
