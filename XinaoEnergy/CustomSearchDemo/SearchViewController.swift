//
//  SearchViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/9/10.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController{
    
    var tableView: UITableView!
    
    var dataArray = [String]() //存储文件内容
    var filteredArray = [String]() //存储搜索结果数据
    var shouldShowSearchResults = false //是否显示搜索结果
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        configureSearchController()
       // loadListOfCountries()
    }
    
    func configureSearchController(){
        //通过参数searchResultsController传nil来初始化UISearchController，意思是我们告诉search controller我们会用相同的视图控制器来展示我们的搜索结果，如果我们想要指定一个不同的view controller，那就会被替代为显示搜索结果。
        searchController = UISearchController(searchResultsController: nil)
        //设置代理，searchResultUpdater是UISearchController的一个属性，它的值必须实现UISearchResultsUpdating协议，这个协议让我们的类在UISearchBar文字改变时被通知到，我们之后会实现这个协议。
        searchController.searchResultsUpdater = self
        //默认情况下，UISearchController暗化前一个view，这在我们使用另一个view controller来显示结果时非常有用，但当前情况我们并不想暗化当前view，即设置开始搜索时背景是否显示
        searchController.dimsBackgroundDuringPresentation = false
        searchController.view.backgroundColor = UIColor.red
        
        searchController.definesPresentationContext = true
        //设置默认显示内容
        searchController.searchBar.placeholder = "Search here..."
        //设置searchBar的代理
        searchController.searchBar.delegate = self
        //设置searchBar自适应大小
        searchController.searchBar.sizeToFit()
        //设置definesPresentationContext为true，我们保证在UISearchController在激活状态下用户push到下一个view controller之后search bar不会仍留在界面上。
        searchController.definesPresentationContext = true
        
        tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-49))
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        dataArray = ["1222","233","1234","325","567"]
        tableView.reloadData()
        //将searchBar设置为tableview的头视图
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func loadListOfCountries(){
        //获取文件的指定路径
        let pathToFile = Bundle.main.path(forResource: "countries", ofType: "txt")
        //判断路径是否存在
        if let path = pathToFile{
            do{
                //加载文件变成字符串
                let countriesString = try String(contentsOfFile: path, encoding: .utf8)
                //将字符串变为数组
                dataArray = countriesString.components(separatedBy: "\n")
                //刷新列表
                tableView.reloadData()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

//扩展SearchViewController实现UITableViewDelegate,UITableViewDataSource两个协议，并控制数据的显示
extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    //MARK: UITableView Delegate and Datasource functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {//是否显示搜索结果
            return filteredArray.count
        }
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = UITableViewCell.init()
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "ss")
        }
        if shouldShowSearchResults{
            cell?.textLabel?.text = dataArray[indexPath.row]
        }else{
            cell?.textLabel?.text = "\(indexPath.row)"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

//扩展SearchViewController实现UISearchBarDelegate和UISearchResultsUpdating两个协议
extension SearchViewController:UISearchBarDelegate,UISearchResultsUpdating{
    
    //开始进行文本编辑，设置显示搜索结果，刷新列表
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    //点击Cancel按钮，设置不显示搜索结果并刷新列表
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    //点击搜索按钮，触发该代理方法，如果已经显示搜索结果，那么直接去除键盘，否则刷新列表
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults{
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    //这个updateSearchResultsForSearchController(_:)方法是UISearchResultsUpdating中唯一一个我们必须实现的方法。当search bar 成为第一响应者，或者search bar中的内容被改变将触发该方法.不管用户输入还是删除search bar的text，UISearchController都会被通知到并执行上述方法。
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        //过滤数据源，存储匹配的数据
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText: NSString = country as NSString
            return   (countryText.range(of: searchString!, options: .caseInsensitive).location) != NSNotFound
        })
        //刷新表格
        tableView.reloadData()
    }
}


