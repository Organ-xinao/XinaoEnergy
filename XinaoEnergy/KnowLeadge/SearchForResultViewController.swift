//
//  SearchForResultViewController.swift
//  buttonDemo
//
//  Created by zx on 1976/4/1.
//  Copyright © 2018年 zx. All rights reserved.
//

import UIKit

class SearchForResultViewController: UIViewController {

    let schoolArray : NSMutableArray = ["清华大学","北京大学","中国人民大学","北京交通大学","北京工业大学",
                       "北京航空航天大学","北京理工大学","北京科技大学","中国政法大学","中央财经大学","华北电力大学",
                       "北京体育大学","上海外国语大学","复旦大学","华东师范大学","上海大学","河北工业大学"]
    let mtableView = UITableView()
    var shouldShowSearchResults = false
    var searchController : UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "知识库"
        //self.navigationController?.isNavigationBarHidden = true
        mtableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        mtableView.separatorStyle = .none
        mtableView.delegate = self
        mtableView.dataSource = self
        view.addSubview(mtableView)
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "搜索框"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.sizeToFit()
        mtableView.tableHeaderView = searchController.searchBar
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchForResultViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        cell?.textLabel?.text = schoolArray[indexPath.row] as? String
        return cell!
    }
    
    
}

//扩展SearchViewController实现UISearchBarDelegate
extension SearchForResultViewController:UISearchBarDelegate,UISearchResultsUpdating{
    //开始进行文本编辑，设置显示搜索结果，刷新列表
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        mtableView.reloadData()
    }
    
    //点击Cancel按钮，设置不显示搜索结果并刷新列表
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        self.dismiss(animated: false, completion: nil)
    }
    
    //点击搜索按钮，触发该代理方法，如果已经显示搜索结果，那么直接去除键盘，否则刷新列表
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults{
            shouldShowSearchResults = true
            
        }
        searchController.searchBar.resignFirstResponder()
        mtableView.reloadData()
    }
    
    //这个updateSearchResultsForSearchController(_:)方法是UISearchResultsUpdating中唯一一个我们必须实现的方法。当search bar 成为第一响应者，或者search bar中的内容被改变将触发该方法.不管用户输入还是删除search bar的text，UISearchController都会被通知到并执行上述方法。
    func updateSearchResults(for searchController: UISearchController) {
        //let searchString = searchController.searchBar.text
        print(searchController.searchBar.text)
        //过滤数据源，存储匹配的数据
//        filteredArray = dataArray.filter({ (country) -> Bool in
//            let countryText: NSString = country as NSString
//            return   (countryText.range(of: searchString!, options: .caseInsensitive).location) != NSNotFound
//        })
        //刷新表格
        mtableView.reloadData()
    }
}



