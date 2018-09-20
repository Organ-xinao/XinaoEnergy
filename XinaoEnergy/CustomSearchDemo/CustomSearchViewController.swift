//
//  CustomSearchViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/9/10.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class CustomSearchViewController: UISearchController {
    var hasCancel:Bool = false
    let deViceSysetmVersion = UIDevice.current.systemVersion as NSString
    
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
        self.dimsBackgroundDuringPresentation = false
        self.hidesNavigationBarDuringPresentation = true
        self.searchBar.frame = CGRect(x: 0, y: 0, width: kScreenWidth-40, height: 44)
        self.searchBar.barStyle = .default
//        self.searchBar.backgroundColor = .red
//        self.searchBar.barTintColor = .white
        self.searchBar.delegate = self
        self.searchBar.autocapitalizationType = .none
        self.searchBar.placeholder = "搜索"
//        self.searchBar.layer.borderColor = UIColor.blue.cgColor
        self.searchBar.contentMode = .center
//        self.searchBar.layer.borderWidth = 1
        self.searchBar.layer.masksToBounds = true
        if deViceSysetmVersion.floatValue >= 11.0 {
            searchBar.setPositionAdjustment(UIOffsetMake((searchBar.frame.size.width - 40.5 - 50 ) / 2 , 0), for: UISearchBarIcon.search)
        }
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
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        var frame = self.searchBar.frame
        frame.size.height = 44
        
        frame.size.width = kScreenWidth-40
        self.searchBar.frame = frame
        if deViceSysetmVersion.floatValue >= 11 {
            searchBar.setPositionAdjustment(UIOffsetMake((searchBar.frame.size.width - 40.5 - 50 ) / 2 , 0), for: UISearchBarIcon.search)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        var searchBarTextField:UITextField?
//        if deViceSysetmVersion.floatValue > 10.0 {
//            searchBarTextField = ((self.searchBar.subviews.first?.subviews)! as NSArray).object(at: 1) as? UITextField
//        } else {
//            searchBarTextField = self.searchBar.subviews.first?.subviews.last as? UITextField
//        }
        
        // 去除边黑边
        self.searchBar.layer.borderColor = UIColor.white.cgColor
//        self.searchBar.tintColor = UIColor.red
        self.searchBar.layer.borderWidth = 1
        self.searchBar.layer.masksToBounds = true
        //由于是打开页面时调用，只写着一种
        var frame = self.searchBar.frame
        frame.size.height = 44
        frame.size.width = kScreenWidth
        self.searchBar.frame = frame
        if deViceSysetmVersion.floatValue >= 11 {
            self.searchBar.setPositionAdjustment(UIOffset.zero, for: UISearchBarIcon.search)
        }
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
        hasCancel = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hasCancel = false
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        if deViceSysetmVersion.floatValue >= 11 {
//            self.searchBar.setPositionAdjustment(UIOffset.zero, for: UISearchBarIcon.search)
//        }
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        if deViceSysetmVersion.floatValue >= 11 {
//            searchBar.setPositionAdjustment(UIOffsetMake((self.searchBar.frame.size.width - 40.5 - 50 ) / 2 , 0), for: UISearchBarIcon.search)
//        }
        return true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        hasCancel = true
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

// 计算placeholder、icon、icon和placeholder间距的总宽度


