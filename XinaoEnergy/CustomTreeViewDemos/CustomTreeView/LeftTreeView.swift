//
//  LeftTreeView.swift
//  XinaoEnergy
//
//  Created by jun on 2018/9/4.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class LeftTreeView: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    var allData:[LeftCellCodeModel] = []
    var showData:[LeftCellCodeModel] = []
    let cellReuseIdentifier:String = "codeCustomCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //print(#function)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: UITableViewStyle.plain)
        setupTab()
    }
    
    func setupTab() {
        self.delegate = self
        self.dataSource = self
        self.register(LeftTreeViewTableViewCell.classForCoder(), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    //MARK - delegate
    // Variable height support
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 40
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 0.01
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0.01
    }
    
    // Called after the user changes the selection.
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let selectModel = showData[indexPath.row]//选中的模型数据
        let cell = tableView.cellForRow(at: indexPath) as! LeftTreeViewTableViewCell
        if selectModel.hasChildren {//如果有子cell，更改打开状态
            selectModel.isOpen = !selectModel.isOpen
        }else{
            return
        }
        //下一个下标
        let nextIndex:Int = indexPath.row+1
        //最后的下标
        var endIndex:Int = nextIndex
        //1.刷新展示数组的数据
        if selectModel.isOpen {//打开，加入数据
            
            cell.accessoryView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2));
            for i in nextIndex..<allData.count{
                if allData[i].superId == selectModel.myId {//如果元素superid是选中的id，即被认为是当前cell的子cell
                    showData.insert(allData[i], at: endIndex)
                    endIndex += 1
                }
            }
        }else{//关闭，删除数据
            cell.accessoryView?.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
            for j in nextIndex..<showData.count{
                if (showData[j].myLevel>selectModel.myLevel) {//如果元素index比选中index大，且级别比选中级别大
                    endIndex += 1
                }else {
                    break
                }
            }
            let deleteRange:Range<Int> = nextIndex..<endIndex
            showData.removeSubrange(deleteRange)
        }
        //2.更新下标数组，以保证对正确下标的row进行操作，因为页面变化，只会影响操作cell以下的cell，所以只需要刷新之下的index即可
        var indexPathArray:[IndexPath] = []
        
        for i in nextIndex..<endIndex {
            let indexPathNeed = NSIndexPath(row: i, section: 0)
            indexPathArray.append(indexPathNeed as IndexPath)
        }
        
        //3.插入或者删除相关节点，执行完这部操作后会调用cell重用方法cellForRowAtIndexPath，重新绘制tabview，实现cell的展开与折叠
        if selectModel.isOpen {
            tableView.insertRows(at: indexPathArray, with: UITableViewRowAnimation.none)
        }else{
            tableView.deleteRows(at: indexPathArray, with: UITableViewRowAnimation.none)
        }
        indexPathArray.removeAll(keepingCapacity: true)
    }
    
    //MARK - dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:LeftTreeViewTableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? LeftTreeViewTableViewCell
        if cell == nil {
            //            cell = UITableViewCell(style: .default, reuseIdentifier: cellReuseIdentifier) as! LeftTreeViewTableViewCell
            cell = LeftTreeViewTableViewCell(style: .default, reuseIdentifier: cellReuseIdentifier)
        }
        let cellModel = showData[indexPath.row]
        cell.indentationWidth=30;   // 缩放宽度
        cell.indentationLevel=cellModel.myLevel;  // 缩放等级
        cell.setupCustomView(withTitle: cellModel.title, level: cellModel.myLevel) //实现cell缩进
        cell.titleLabel.text = cellModel.title
//        cell.rightImage.image = UIImage(named: "rightBtn")
        cell.accessoryView = UIImageView.init(image: UIImage(named: "rightBtn"))
        //        print("section\(indexPath.section)row\(indexPath.row)")
        return cell!
    }

}
