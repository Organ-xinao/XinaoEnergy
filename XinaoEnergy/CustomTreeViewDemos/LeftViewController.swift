//
//  LeftViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/9/4.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {
    
    var customTab = LeftTreeView()
    var customTab2 = LeftTreeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTab()
        setTab2()
    }
    func  setTab(){
        customTab.frame = CGRect(x: 0, y: 0, width: kScreenWidth/2, height: kScreenHeight-49)
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
    func  setTab2(){
        customTab2.frame = CGRect(x: kScreenWidth/2, y: 0, width: kScreenWidth/2, height: kScreenHeight-49)
        customTab2.backgroundColor = UIColor.white
        self.view.addSubview(customTab2)
        for i in 0...10{
            let genModel = LeftCellCodeModel(superId:-1, myId: i, myLevel:0, hasChildren:true, isOpen: false, title: "根\(i)", image: UIImage(named: "rightBtn")!)
            customTab2.allData.append(genModel)
            customTab2.showData.append(genModel)
            for j in 0...3{
                if (i == 1 || i == 2) {
                    customTab2.allData.append(LeftCellCodeModel(superId: i, myId: Int("\(i)\(j)")!, myLevel:1, hasChildren:true, isOpen: false, title: "二级\(i)_\(j)", image: UIImage(named: "rightBtn")!))
                    //                    for k in 0...1{
                    //                        if (j == 1){
                    //                            allData.append(LeftCellCodeModel(superId: Int("\(i)\(j)")!, myId: Int("\(i)\(j)\(k)")!, myLevel:2, hasChildren:false, isOpen: false, title: "san级\(i)_\(j)\(k)", image: UIImage(named: "rightBtn")!))
                    //                        }
                    //                    }
                }
            }
        }
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
