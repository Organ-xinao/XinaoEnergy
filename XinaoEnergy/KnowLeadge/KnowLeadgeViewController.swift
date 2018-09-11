//
//  UITableViewController.swift
//  buttonDemo
//
//  Created by zx on 1976/4/1.
//  Copyright © 2018年 zx. All rights reserved.
//

import UIKit

class KnowLeadgeViewController: UIViewController,UIGestureRecognizerDelegate {
    
    let oneMeanArr : Array<String> = ["全部","基础类","进阶类","高级类","拔高类","终极类","究极类"]
    let listArr : Array<String> = ["人类起源","人类初级进化","人类中极进化","人类高级进化","人类终极进化","人类升华"]
    var tableView1 = UITableView()
    var statusArr : NSMutableArray = NSMutableArray()
    var colltionView : UICollectionView?
    let ScreenWidth  = UIScreen.main.bounds.width
    let ScreenHeight = UIScreen.main.bounds.height
    let IdentifierC = "MyUICollectionViewCell"
    let headerIdentifier = "CollectionHeaderView"
    let footIdentifier = "CollectionFootView"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "菜单"
        addData()
        setSearchView()
        setTableView()
        setCollectionView()
        // Do any additional setup after loading the view.
    }
    //UIApplication.shared.statusBarFrame.height+(self.navigationController?.navigationBar.frame.size.height)!
    
    func setSearchView(){
        view.backgroundColor = UIColor.white
        let searchViewFrame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height, width: UIScreen.main.bounds.width, height: 40)
        let gesture = UITapGestureRecognizer()
        gesture.delegate = self
        gesture.addTarget(self, action: #selector(toSearchData))
        let searchView = UIView()
        searchView.frame = searchViewFrame
        searchView.backgroundColor = UIColor.orange
        let mLabel = UILabel()
        mLabel.text = "搜索"
        mLabel.textColor = UIColor.gray
        mLabel.sizeToFit()
        searchView.addSubview(mLabel)
        let mImageView = UIImageView(image :UIImage(named: "sousuo"))
        mImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        searchView.addSubview(mImageView)
//        searchView.frame = CGRect(x: view.frame.width/2 - (mLabel.frame.width+mImageView.frame.width)/2, y: (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height, width: (mLabel.frame.width+mImageView.frame.width), height: 40)
        mImageView.frame.origin.x = searchView.frame.width/2-mLabel.frame.width/2-mImageView.frame.width/2
        mImageView.frame.origin.y = searchView.frame.height/2-mImageView.frame.height/2
        mLabel.frame.origin.x = searchView.frame.width/2 - mLabel.frame.width/2+mImageView.frame.width/2
        mLabel.frame.origin.y = searchView.frame.height/2-mLabel.frame.height/2
        searchView.layer.cornerRadius = 5
        searchView.addGestureRecognizer(gesture)
        view.addSubview(searchView)
    }
    
    @objc func toSearchData(){
        print("搜索按钮")
        self.present(SearchForResultViewController(), animated: false, completion: nil)
    }
    func setTableView(){
        let rect1 = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height+40, width: view.frame.size.width*0.3, height: ScreenHeight-((self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height+40))
        tableView1.frame = rect1
        self.tableView1.showsVerticalScrollIndicator = false
        tableView1.register(UITableViewControllerCellTwo.self, forCellReuseIdentifier: "tableCell")
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView1.separatorStyle = UITableViewCellSeparatorStyle.none
        view.addSubview(tableView1)
    }
    
    func setCollectionView(){
        let rect2 = CGRect(x: view.frame.size.width*0.3, y: (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height+40, width: view.frame.size.width*0.7, height: ScreenHeight-((self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height+40))
        let layout = UICollectionViewFlowLayout() //创建layout
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .vertical //设置滚动方向
        layout.minimumInteritemSpacing = 5 //水平方向间距
        layout.minimumLineSpacing = 5 //垂直方向间距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)  //设置四周得边缘距离
        // 设置分区头视图和尾视图宽高
        layout.headerReferenceSize = CGSize.init(width: view.frame.size.width*0.7, height: 20)
        layout.footerReferenceSize = CGSize.init(width: view.frame.size.width*0.7, height: 20)
        colltionView = UICollectionView(frame: rect2, collectionViewLayout: layout)
        colltionView?.backgroundColor = UIColor.white
        colltionView?.delegate = self
        colltionView?.dataSource = self
        // 注册cell
        colltionView?.register(MyUICollectionViewCell.self, forCellWithReuseIdentifier: IdentifierC)
        // 注册headerView
        colltionView?.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        // 注册footView
        colltionView?.register(CollectionFootView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footIdentifier)
        
        view.addSubview(colltionView!)
    }
    
    func addData(){
        for _ in 0..<oneMeanArr.count{
            statusArr.add(false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension KnowLeadgeViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView:UITableView) ->Int {
        
        return oneMeanArr.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if statusArr[section] as! Bool{
            return listArr.count
        }else{
            return 0
        }
        
    }
    func tableView(_ tableView:UITableView, heightForRowAt indexPath:IndexPath) ->CGFloat {
        
        return 40
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UITableViewControllerCellOne = UITableViewControllerCellOne()
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width*0.3, height: view.frame.size.height)
        view.tag = section + 1000
        view.isSelected = statusArr[section] as! Bool
        view.callBack = {(index : Int,isSelected : Bool) in
            let i = index - 1000
            if self.statusArr[i] as! Bool{
                self.statusArr[i] = false
            }else{
                self.statusArr[i] = true
            }
            print(index)
            self.reLoadCollectionView(option: "区域头被点击å")
            self.tableView1.reloadSections(IndexSet.init(integer: i), with: UITableViewRowAnimation.automatic)
        }
        view.mLabel.text = oneMeanArr[section]
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "reusedCell1"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? UITableViewControllerCellTwo
        if cell == nil{
            cell = UITableViewControllerCellTwo(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        let rowNum = indexPath.row
        cell?.mLabel.text = listArr[rowNum]
        cell?.mLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        return cell!
    }
    //tableView点击事件
    func tableView(_ tableView:UITableView,didSelectRowAt indexPath:IndexPath){
        print(indexPath.row)
        reLoadCollectionView(option:"区域行被电击")
        
    }
    
}

extension KnowLeadgeViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    //    //header高度
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //        return CGSize.init(width: ScreenWidth, height: 80)
    //    }
    
    //设定header和footer的方法，根据kind不同进行不同的判断即可
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader{
            let headerView : CollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! CollectionHeaderView
            headerView.view.backgroundColor = UIColor.red
            headerView.label.text = "This is HeaderView"
            return headerView
        }else{
            let footView : CollectionFootView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footIdentifier, for: indexPath) as! CollectionFootView
            footView.view.backgroundColor = UIColor.purple
            footView.label.text = "This is Foot"
            return footView
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MyUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: IdentifierC, for: indexPath) as! MyUICollectionViewCell
        cell.clabel.text = String(format:"%ditem",indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    //MASK: 从新加载collectionView
    func reLoadCollectionView(option index : String){
        print(index)
        colltionView?.reloadData()
    }
}
