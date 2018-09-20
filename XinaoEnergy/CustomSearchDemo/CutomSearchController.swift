//
//  CutomSearchController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/9/14.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

//自定义协议
protocol CustomSearchControllerDelegate{
    func didStartSearching()
    func didTapOnSearchButton()
    func didTapOnCancelButton()
    func didChangeSearchText(searchText: String)
}

class CustomSearchController: UISearchController {
    
    //拥有自定义CustomSearchBar和代理对象
    var customSearchBar: CustomSearchBar!
    var customDelegate: CustomSearchControllerDelegate!
    
    //1：构造初始化方法
    init(searchResultsController: UIViewController?,searchBarFrame: CGRect,searchBarFont: UIFont,searchBarTextColor: UIColor,searchBarTintColor: UIColor) {
        super.init(searchResultsController: searchResultsController)
        configureSearchBar(frame: searchBarFrame, font: searchBarFont, textColor: searchBarTextColor, bgColor: searchBarTintColor)
    }
    
    //2：实现两个必须实现的方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    //3：自定义方法对SearchBar进行设置
    func configureSearchBar(frame: CGRect, font: UIFont, textColor: UIColor, bgColor: UIColor) {
        //创建自定义SearchBar
        customSearchBar = CustomSearchBar(frame: frame, font: font , textColor: textColor)
        //设置SearchBar相应的属性内容
        customSearchBar.barTintColor = bgColor
        customSearchBar.tintColor = textColor
        customSearchBar.showsBookmarkButton = false
        customSearchBar.showsCancelButton = true
        customSearchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension CustomSearchController: UISearchBarDelegate{
    
    //当开始编辑search field，使用代理执行相应的协议方法
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        customDelegate.didStartSearching()
    }
    
    //当搜索按钮被点击，触发方法，取消键盘
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar.resignFirstResponder()
//        customDelegate.didTapOnSearchButton()
    }
    
    //点击取消按钮
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar.resignFirstResponder()
//        customDelegate.didTapOnCancelButton()
    }
    
    //文本发生改变
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        customDelegate.didChangeSearchText(searchText: searchText)
    }
}


