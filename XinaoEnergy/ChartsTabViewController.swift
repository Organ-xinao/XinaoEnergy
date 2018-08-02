//
//  ChartsTabViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/31.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class ChartsTabViewController: UIViewController {

    let buttons:NSMutableArray = ["折线图", "柱状图", "饼图"]
    // 把类定义成属性
    let linebutton = LineButton()
    // view
    var  buttonView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let lineViewcontroller = LineChartsViewController()
//        lineViewcontroller.tabBarItem.title = "折线图"
//        lineViewcontroller.tabBarItem.tag = 0
//        let barViewController = BarChartsViewController()
//        barViewController.tabBarItem.title = "柱状图"
//        barViewController.tabBarItem.tag = 1
//        let pieViewController = PieChartsViewController()
//        pieViewController.tabBarItem.title = "饼图"
//        pieViewController.tabBarItem.tag = 2
//
//        self.tabBarController?.viewControllers = [lineViewcontroller, barViewController, pieViewController]
        
        self.view.backgroundColor = UIColor.white
        layoutView()
    }
    
    func layoutView(){
        // 先删除
        if buttonView != nil{
            buttonView.removeFromSuperview()
            buttonView = nil
        }
        // 再创建
        buttonView = linebutton.creatLineButton(dataArr: buttons)
        //buttonView.center = view.center
        self.view.addSubview(buttonView)
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
