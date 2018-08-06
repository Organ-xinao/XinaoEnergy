//
//  KnowLeadgeViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/20.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class KnowLeadgeViewController: UIViewController{
    let meanArr : Array<String> = ["全部","基础类","进阶类","高级类","拔高类","终极类","究极类"]
    let listArr : Array<(String,String)> = [("人类起源","pdf-2"),("人类初级进化","Group 8 Copy 3"),("人类中极进化","pdf-2"),("人类终极进化","pdf-2"),("人类高级进化","pdf-2"),("人类升华","pdf-2")]//"人类起源","人类初级进化","人类中极进化","人类高级进化","人类终极进化","人类升华"
    var tableView1 = UITableView()
    var tableView2 = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setFrameLayout()
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setFrameLayout(){
        
//        let scrollView : UIScrollView = UIScrollView()
//        scrollView.delegate = self
//        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width*0.4, height: view.frame.size.height)
//        scrollView.contentSize = CGSize(width: view.frame.size.width*0.4, height: view.frame.size.height)
//        scrollView.layer.borderWidth = 1
//        scrollView.layer.borderColor = UIColor.green.cgColor
//        view.addSubview(scrollView)
        
        let rect1 = CGRect(x: 0, y: 0, width: Int(view.frame.size.width*0.3), height: (meanArr.count+2)*40)
        let rect2 = CGRect(x: view.frame.size.width*0.3, y: 0, width: view.frame.size.width*0.7, height: view.frame.size.height)
        tableView1.frame = rect1
        tableView2.frame = rect2
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView2.dataSource = self
        tableView2.delegate = self
        tableView2.register(KnowLeadgeTableViewCell.self, forCellReuseIdentifier: "tableCell")
        //tableView1.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView2.separatorStyle = UITableViewCellSeparatorStyle.none
        view.addSubview(tableView1)
        view.addSubview(tableView2)
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
extension KnowLeadgeViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView:UITableView) ->Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.isEqual(self.tableView1){
            return meanArr.count
        }else{
            return listArr.count
        }
    }
    func tableView(_ tableView:UITableView, heightForRowAt indexPath:IndexPath) ->CGFloat {
        
        return 40
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //设置两个tableView的内容
        if tableView.isEqual(self.tableView1) {
            let identifier = "reusedCell1"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            if cell == nil{
                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            }
            let rowNum = indexPath.row
            cell?.textLabel?.text = meanArr[rowNum]
            cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            return cell!
        }else {
            let identifier2 = "reusedCell2"
            var cell2 = tableView.dequeueReusableCell(withIdentifier: identifier2) as? KnowLeadgeTableViewCell
            if cell2 == nil{
                cell2 = KnowLeadgeTableViewCell(style: .default, reuseIdentifier: identifier2)
            }
            let rowNum = indexPath.row
            cell2?.mLabel.text = listArr[rowNum].0
            cell2?.mImageView.image = UIImage(named: listArr[rowNum].1)
            return cell2!
        }
        
    }
        //tableView点击事件
        func tableView(_ tableView:UITableView,didSelectRowAt indexPath:IndexPath){
//            let cell = tableView.cellForRow(at: indexPath)
//            if cell?.accessoryType == UITableViewCellAccessoryType.none{
//                cell?.accessoryType = UITableViewCellAccessoryType.checkmark
//                print("checked")
//            }else{
//                cell?.accessoryType = UITableViewCellAccessoryType.none
//            }
            if tableView.isEqual(self.tableView1) {
                tableView2.reloadData()
                /// 执行第一个 table 的代码
                //取消选中的样式
                
//                tableView.deselectRow(at: indexPath, animated: true)
//
//                //获取当前选中的单元格
//
//                let cell:UITableViewCell! = tableView.cellForRow(at: indexPath)
//
//                //返回所有单元格
//
//                //遍历取消所有单元格样式
//
//                var arry = tableView.visibleCells
//
//                for i in 0 ..< arry.count {
//
//                    let cells: UITableViewCell = arry[i]
//
//                    cells.accessoryType = .none
//
//                }
//
//                //设置选中的单元格样式
//
//                cell.accessoryType = .checkmark
                
            }else {
                /// 执行第一个 table 的代码
            }
    
        }

}
