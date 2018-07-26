//
//  TableViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/24.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

var todos:[todoModel] = []
class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    //拉刷新控制器
    var refreshControl = UIRefreshControl()
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        todos = [todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1")]
        // Do any additional setup after loading the view.
        //添加刷新
        refreshControl.addTarget(self, action: #selector(TableViewController.refreshData),
                                 for: UIControlEvents.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tableView.addSubview(refreshControl)
    }
    //滚动视图开始拖动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if !refreshControl.isRefreshing {
            refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        }
    }
    
    @objc func refreshData(){
        refreshControl.attributedTitle = NSAttributedString(string: "数据加载中......")
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self,
                                     selector: #selector(TableViewController.timeOut), userInfo: nil, repeats: true)
    }
    
    //计时器时间到
    @objc func timeOut() {
        //移除老数据
        todos.removeAll()
        //随机添加5条新数据（时间是当前时间）
        for _ in 0..<5 {
            let atricle = todoModel(title: "新闻标题\(Int(arc4random()%1000))")
            todos.append(atricle)
        }
        tableView.reloadData()
        self.refreshControl.endRefreshing()
        
        //停止定时器
        timer.invalidate()
        timer = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //重写dataSource的方法
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todos.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "todoCell")! as UITableViewCell
        let todo :todoModel
        todo = todos[indexPath.row]
        let title = cell.viewWithTag(101) as! UILabel
        title.text = todo.title
        
        return cell
    }
    //Mark - 重写delegate方法
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
    //        if editingStyle == UITableViewCellEditingStyle.delete {
    //            // 删除数据源中对应的数据
    //            todos.remove(at: indexPath.row)
    //            //这仅仅是页面删除，切记要将数据源中的数据删除
    //            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
    //        }
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

