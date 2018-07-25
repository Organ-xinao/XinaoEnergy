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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        todos = [todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1"),todoModel(title:"1")]
        // Do any additional setup after loading the view.
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
//        let todo :todoModel
//            todo = todos[indexPath.row]
        let title = cell.viewWithTag(101) as! UILabel
        title.text = "我是第"+String(indexPath.row)+"行"
        
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
