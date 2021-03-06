
//
//  LeftTreeViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/8/29.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class LeftTreeViewController: UIViewController,RATreeViewDelegate, RATreeViewDataSource {
    
    var treeView : RATreeView!
    var data : [DataObject]
    var editButton : UIBarButtonItem!
    
    convenience init() {
        self.init(nibName : nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        data = LeftTreeViewController.commonInit()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        data = LeftTreeViewController.commonInit()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Things"
        setupTreeView()
        //updateNavigationBarButtons()
    }
    
    func setupTreeView() -> Void {
        treeView = RATreeView(frame: view.bounds)
        treeView.register(UINib(nibName: String(describing: TreeTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TreeTableViewCell.self))
        treeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        treeView.delegate = self;
        treeView.dataSource = self;
        treeView.treeFooterView = UIView()
        treeView.backgroundColor = .clear
        view.addSubview(treeView)
    }
    
//    func updateNavigationBarButtons() -> Void {
//        let systemItem = treeView.isEditing ? UIBarButtonSystemItem.done : UIBarButtonSystemItem.edit;
//        self.editButton = UIBarButtonItem(barButtonSystemItem: systemItem, target: self, action: #selector(LeftTreeViewController.editButtonTapped(_:)))
//        self.navigationItem.rightBarButtonItem = self.editButton;
//    }
//
//    @objc func editButtonTapped(_ sender: AnyObject) -> Void {
//        treeView.setEditing(!treeView.isEditing, animated: true)
//        updateNavigationBarButtons()
//    }
    
    //MARK - RATreeviewdataSource
    func treeView(_ treeView: RATreeView, numberOfChildrenOfItem item: Any?) -> Int {
        if let item = item as? DataObject {
            return item.children.count
        } else {
            return self.data.count
        }
    }
    
    func treeView(_ treeView: RATreeView, child index: Int, ofItem item: Any?) -> Any {
        if let item = item as? DataObject {
            return item.children[index]
        } else {
            return data[index] as AnyObject
        }
    }
    
    func treeView(_ treeView: RATreeView, cellForItem item: Any?) -> UITableViewCell {
        let cell = treeView.dequeueReusableCell(withIdentifier: String(describing: TreeTableViewCell.self)) as! TreeTableViewCell
        let item = item as! DataObject
        
        let level = treeView.levelForCell(forItem: item)
        let detailsText = "Number of children \(item.children.count)"
        cell.selectionStyle = .none
        cell.setup(withTitle: item.name, detailsText: detailsText, level: level, additionalButtonHidden: false)
        cell.additionButtonActionBlock = { [weak treeView] cell in
            guard let treeView = treeView else {
                return;
            }
            let item = treeView.item(for: cell) as! DataObject
            let newItem = DataObject(name: "Added value")
            item.addChild(newItem)
            treeView.insertItems(at: IndexSet(integer: item.children.count-1), inParent: item, with: RATreeViewRowAnimationNone);
            treeView.reloadRows(forItems: [item], with: RATreeViewRowAnimationNone)
        }
        return cell
    }
    
    //MARK: RATreeView delegate
    func treeView(_ treeView: RATreeView, canEditRowForItem item: Any) -> Bool {//关闭编辑功能
        return false
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

private extension LeftTreeViewController {
    
    static func commonInit() -> [DataObject] {
        let phone1 = DataObject(name: "Phone 1")
        let phone2 = DataObject(name: "Phone 2")
        let phone3 = DataObject(name: "Phone 3")
        let phone4 = DataObject(name: "Phone 4")
        let phones = DataObject(name: "Phones", children: [phone1, phone2, phone3, phone4])
        
        let notebook1 = DataObject(name: "Notebook 1")
        let notebook2 = DataObject(name: "Notebook 2")
        
        let computer1 = DataObject(name: "Computer 1", children: [notebook1, notebook2])
        let computer2 = DataObject(name: "Computer 2")
        let computer3 = DataObject(name: "Computer 3")
        let computers = DataObject(name: "Computers", children: [computer1, computer2, computer3])
        
        let cars = DataObject(name: "Cars")
        let bikes = DataObject(name: "Bikes")
        let houses = DataObject(name: "Houses")
        let flats = DataObject(name: "Flats")
        let motorbikes = DataObject(name: "motorbikes")
        let drinks = DataObject(name: "Drinks")
        let food = DataObject(name: "Food")
        let sweets = DataObject(name: "Sweets")
        let watches = DataObject(name: "Watches")
        let walls = DataObject(name: "Walls")
        
        return [phones, computers, cars, bikes, houses, flats, motorbikes, drinks, food, sweets, watches, walls]
    }
    
}
