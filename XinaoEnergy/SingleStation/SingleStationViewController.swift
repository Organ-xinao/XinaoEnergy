//
//  SingleStationViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/8/27.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class SingleStationViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchControllerDelegate {
    var collectionView:UICollectionView!
    var customTab = LeftTreeView()
    var searchController:CustomSearchViewController!
    var customSearchController:CustomSearchController!
    var searchView:UIView!
//    var searchBar:UISearchBar!
    var shouldShowSearchResults = false //是否显示搜索结果
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createSearchBar()
        setTab()
        layoutCollectionView()
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func viewDidLayoutSubviews () {
        
//        let deViceSysetmVersion = UIDevice.current.systemVersion as NSString
//        var searchBarTextField:UITextField?
//        if deViceSysetmVersion.floatValue > 10.0 {
//            searchBarTextField = ((searchController.searchBar.subviews.first?.subviews)! as NSArray).object(at: 1) as? UITextField
//        } else {
//            searchBarTextField = searchController.searchBar.subviews.first?.subviews.last as? UITextField
//        }
//
//        if shouldShowSearchResults == true{
//            searchController.searchBar.frame = CGRect(x: 0, y: -20, width: kScreenWidth, height: 44)
//            searchBarTextField?.tintColor = UIColor.red
//            searchBarTextField?.frame = CGRect(x: (searchBarTextField?.frame.origin.x)!, y: (searchBarTextField?.frame.origin.y)!, width: kScreenWidth, height: 44)
//        }else{
//            searchController.searchBar.frame = CGRect(x: 0, y: 20, width: kScreenWidth-40, height: 44)
//            searchBarTextField?.tintColor = UIColor.red
//            searchBarTextField?.frame = CGRect(x: (searchBarTextField?.frame.origin.x)!, y: (searchBarTextField?.frame.origin.y)!, width: kScreenWidth-40, height: 44)
//        }
//        print(searchController.searchBar.subviews.first?.subviews)
        
    }
    
    func createSearchBar(){
        // 创建searchResultVC
//        let searchResultVC = CustomSearchViewController()
//        // 设置背景颜色为红色
////        searchResultVC.view.backgroundColor = UIColor.red
//        let resultNav = UINavigationController(rootViewController: searchResultVC)
//        //通过参数searchResultsController传nil来初始化UISearchController，意思是我们告诉search controller我们会用相同的视图控制器来展示我们的搜索结果，如果我们想要指定一个不同的view controller，那就会被替代为显示搜索结果。
        searchController = CustomSearchViewController(searchResultsController: nil)
        
        // 设置背景颜色
        searchController.view.backgroundColor = UIColor (red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
        
        searchView = UIView.init(frame: CGRect(x: 0, y: 20, width: kScreenWidth, height: searchController.searchBar.frame.height))
        searchView.backgroundColor = UIColor(red: 37/255, green: 46/255, blue: 71/255, alpha: 1.0)
        let rightBtn = UIButton.init(frame: CGRect(x: kScreenWidth-35, y: 9.5, width: 25, height: 25))
        rightBtn.setImage(UIImage(named: "扫描"), for: UIControlState.normal)
        rightBtn.tintColor = UIColor(red: 130/255, green: 197/255, blue: 255/255, alpha: 1)
        rightBtn.addTarget(self, action: #selector(openCamera), for: UIControlEvents.touchUpInside)
        searchView.addSubview(rightBtn)
        self.view.addSubview(searchView)
        searchView.addSubview(searchController.searchBar)
        
        //设置searchBar的代理
        searchController.delegate = self
        searchController.searchBar.delegate = self
        //设置代理，searchResultUpdater是UISearchController的一个属性，它的值必须实现UISearchResultsUpdating协议，这个协议让我们的类在UISearchBar文字改变时被通知到，我们之后会实现这个协议。
        searchController.searchResultsUpdater = self
        
        
        //默认情况下，UISearchController暗化前一个view，这在我们使用另一个view controller来显示结果时非常有用，但当前情况我们并不想暗化当前view，即设置开始搜索时背景是否显示
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        //设置definesPresentationContext为true，我们保证在UISearchController在激活状态下用户push到下一个view controller之后search bar不会仍留在界面上。
        self.definesPresentationContext = true
        
    }
    
    @objc func openCamera () {
        print("打开相机")
    }
    //TabView
    func  setTab(){
        customTab.frame = CGRect(x: 0, y: CGFloat(KMaskHeight), width: kScreenWidth/3, height: kScreenHeight-49-CGFloat(KMaskHeight))
        customTab.backgroundColor = UIColor.white
        self.view.addSubview(customTab)
        for i in 0...10{
            let genModel = LeftCellCodeModel(superId:-1, myId: i, myLevel:0, hasChildren:true, isOpen: false, title: "根\(i)", image: UIImage(named: "rightBtn")!)
            customTab.allData.append(genModel)
            customTab.showData.append(genModel)
            for j in 0...3{
                if (i == 1 || i == 2) {
                    customTab.allData.append(LeftCellCodeModel(superId: i, myId: Int("\(i)\(j)")!, myLevel:1, hasChildren:true, isOpen: false, title: "二级\(i)_\(j)", image: UIImage(named: "rightBtn")!))
                    for k in 0...1{
                        if (j == 1){
                            customTab.allData.append(LeftCellCodeModel(superId: Int("\(i)\(j)")!, myId: Int("\(i)\(j)\(k)")!, myLevel:2, hasChildren:false, isOpen: false, title: "san级\(i)_\(j)\(k)", image: UIImage(named: "rightBtn")!))
                        }
                    }
                }
            }
        }
    }
    //collectionView
    func layoutCollectionView() {
        let layout = UICollectionViewFlowLayout.init()
        
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
//属性设置layout
        //item尺寸
//        layout.itemSize = CGSize.init(width: (kScreenWidth-25)/2, height: 80)
//        //行间距
//        layout.minimumLineSpacing = 5
//        //item间距
//        layout.minimumInteritemSpacing = 5
//        //分组margin
//        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 0, right: 10)
        // 设置分区头视图和尾视图宽高
//        layout.headerReferenceSize = CGSize.init(width: kScreenWidth, height: 30)
        collectionView = UICollectionView(frame: CGRect(x: kScreenWidth/3, y: CGFloat(KMaskHeight), width: kScreenWidth/3*2, height: kScreenHeight-49-CGFloat(KMaskHeight)), collectionViewLayout: layout)

        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(UINib.init(nibName: "RealTimeProvideViewCell", bundle: nil), forCellWithReuseIdentifier: "rtpcell")
        collectionView.register(UINib.init(nibName: "RealtimeTopTwoViewCell", bundle: nil), forCellWithReuseIdentifier: "topTwoCell")
        collectionView.register(RealTimeReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - uciollectionViewDataSource
    @available(iOS 6.0, *)
    public func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 3
    }
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if section == 0 {
            collectionView.isScrollEnabled = true
            collectionView.isDirectionalLockEnabled = false
            collectionView.showsHorizontalScrollIndicator = true
            return 2
        }else{
            return 3
        }
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
       
        if indexPath.section == 0 {
            
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "topTwoCell", for: indexPath) as! RealTimeTopTwoCollectionViewCell
            topCell.titleLabel.text = "溴冷机"
            return topCell
        }else{
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rtpcell", for: indexPath) as! RealTimeProvideCollectionViewCell
            cell.title.text = "产冷"
            cell.imageIcon.image = UIImage(named: "产冷 copy")
            cell.value.text = "100000"
            cell.unit.text = "kW"
            return cell
        }
//        let todo :RealTimeProvideModel
//        todo = todos[indexPath.row]
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        var reusableview:UICollectionReusableView!
        
        if kind == UICollectionElementKindSectionHeader
        {
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! RealTimeReusableView
            
            (reusableview as! RealTimeReusableView).label.text = String(format: "第 %d 个页眉", arguments: [indexPath.section])
        }
//        else if kind == UICollectionElementKindSectionFooter
//        {
//            reusableview = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath) as! CollectionReusableViewFooter
//
//            (reusableview as! CollectionReusableViewFooter).label.text = String(format: "第 %d 个页脚", arguments: [indexPath.section])
//        }
        

        return reusableview
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize.init(width: (kScreenWidth/3*2-25)/2, height: 160)
        }else{
            return CGSize.init(width: (kScreenWidth/3*2-25)/2, height: 80)
        }
    
    }
    //cell左右边距
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    //cell上下边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    //设置section的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // let frame : CGRect = self.view.frame
        // let margin = (frame.width - 90 * 3) / 6.0
        return UIEdgeInsetsMake(10, 10, 0, 10) // margin between sections
    }
    //设置sectionHeader的大小
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: kScreenWidth-20, height: 30)
    }
    

}
extension SingleStationViewController:UISearchBarDelegate, UISearchResultsUpdating{
    //开始进行文本编辑，设置显示搜索结果，刷新列表
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
//        tableView.reloadData()
    }
    
    //点击Cancel按钮，设置不显示搜索结果并刷新列表
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
//        tableView.reloadData()
//        searchView.frame = CGRect(x: 0, y: 20, width: kScreenWidth-40, height: searchController.searchBar.frame.height)
        
    }
    
    //点击搜索按钮，触发该代理方法，如果已经显示搜索结果，那么直接去除键盘，否则刷新列表
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if !shouldShowSearchResults{
            shouldShowSearchResults = true
//            tableView.reloadData()
        }
        //searchController.searchBar.resignFirstResponder()
    }
    
    //这个updateSearchResultsForSearchController(_:)方法是UISearchResultsUpdating中唯一一个我们必须实现的方法。当search bar 成为第一响应者，或者search bar中的内容被改变将触发该方法.不管用户输入还是删除search bar的text，UISearchController都会被通知到并执行上述方法。
    func updateSearchResults(for searchController: UISearchController) {
//        let searchString = searchController.searchBar.text
        print(shouldShowSearchResults)
        //过滤数据源，存储匹配的数据
//        filteredArray = dataArray.filter({ (country) -> Bool in
//            let countryText: NSString = country as NSString
//            return   (countryText.range(of: searchString!, options: .caseInsensitive).location) != NSNotFound
//        })
//        //刷新表格
//        tableView.reloadData()
    }

}
