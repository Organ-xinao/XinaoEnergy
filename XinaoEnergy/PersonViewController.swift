//
//  PersonViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/20.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var personalTable:UITableView!
    var tableCellModels :[NSArray] = NSMutableArray() as! [NSArray]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTableView()
    }
    
    func createTableView () {
        personalTable = UITableView.init(frame: CGRect(x: 0, y: 200, width: kScreenWidth, height: kScreenHeight-200), style: UITableViewStyle.grouped)
        personalTable.delegate = self
        personalTable.dataSource = self
//        personalTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine
        //注册UITableView，cellID为重复使用cell的Identifier
       // personalTable.register(PersonalTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableCellModels = [[PersonTableViewCellModel(itemId: "1", itemImage: "passWord", itemTitle: "密码", itemRightIcon: "rightBtn" ,itemRightTitle:"修改"),PersonTableViewCellModel(itemId: "1", itemImage: "erweima", itemTitle: "二维码", itemRightIcon: "rightBtn" ,itemRightTitle:"erweima1")],[PersonTableViewCellModel(itemId: "1", itemImage: "help", itemTitle: "帮助说明", itemRightIcon: "rightBtn" ,itemRightTitle:""),PersonTableViewCellModel(itemId: "1", itemImage: "clear", itemTitle: "清除缓存", itemRightIcon: "rightBtn" ,itemRightTitle:"100M"),PersonTableViewCellModel(itemId: "1", itemImage: "version", itemTitle: "当前版本", itemRightIcon: "rightBtn" ,itemRightTitle:"1.0")]]

        //必须将高度重置，不然下面设置header无效
        self.personalTable.estimatedRowHeight = 0;
        self.personalTable.estimatedSectionHeaderHeight = 0;
        self.personalTable.estimatedSectionFooterHeight = 0;
        //去除表格上放多余的空隙
//        self.personalTable.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        
        self.view.addSubview(personalTable!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //#MARK - delegate
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50.0
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 10
    }
    
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    //将分组尾设置为一个空的View
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let cell = tableView.cellForRow(at: indexPath) as! PersonalTableViewCell

            print(cell)
    }
    
    //#MARK - datasoure
    public func numberOfSections(in tableView: UITableView) -> Int{
        return tableCellModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableCellModels[section] as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //这里做自定义cell重用
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PersonalTableViewCell
        
        if cell == nil {
            
            cell = PersonalTableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "cell")
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            NSLog("初始化cell")
            
        }
        let tableCellModel :PersonTableViewCellModel
        tableCellModel = tableCellModels[indexPath.section][indexPath.row] as! PersonTableViewCellModel
        
        cell?.itemImage?.image = UIImage.init(named: tableCellModel.itemImage)
        
        cell?.itemRightIcon?.image = UIImage.init(named: tableCellModel.itemRightIcon)
        cell?.itemTitle?.text = tableCellModel.itemTitle//String(indexPath.section)+","+String(indexPath.row)
        if indexPath.section == 0 && indexPath.row == 0 {
            cell?.itemImage?.backgroundColor = UIColor.init(red: 53/255, green: 169/255, blue: 255/255, alpha: 1)
        }else if indexPath.section == 0 && indexPath.row == 1 {
            cell?.itemImage?.backgroundColor = UIColor.init(red: 82/255, green: 204/255, blue: 166/255, alpha: 1)
            let rightImg: UIImageView = UIImageView.init(frame: CGRect(x: kScreenWidth-70, y: 15, width: 20, height: 20))
            rightImg.image = UIImage.init(named: tableCellModel.itemRightTitle)
            cell?.contentView.addSubview(rightImg)
        }
//        (cell as! PersonalTableViewCell).setMsgModle(array[indexPath.row])
        
        return cell!
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
