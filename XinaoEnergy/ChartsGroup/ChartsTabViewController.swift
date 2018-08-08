//
//  ChartsTabViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/31.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class ChartsTabViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, LineButtonDelagate{

    let buttons:NSMutableArray = ["折线图", "柱状图", "饼图"]
    // 把类定义成属性
    let linebutton = LineButton()
    // view
    var  buttonView:UIView!
    //pageviewController
    var pageController:UIPageViewController!
    //controllers
    var viewControllers = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        layoutView()
        createPageController()
    }
    
    //搭建子页面
    func createPageController() {
        //初始化
        pageController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionSpineLocationKey:NSNumber(value: 3)])
        pageController.view.frame = CGRect(x:0, y:124, width:kScreenWidth, height:kScreenHeight-124)
        pageController.delegate=self
        
        //当改为self的时候，打开手势滑动
        pageController.dataSource = nil
        
        //初始化要展示的Controller,自定义
        viewControllers = [LineChartsViewController(), BarChartsViewController(),PieChartsViewController()]
        //展示之前进行初始化第一个Controller, 单个显示放一个,两个显示则放两个,和样式有关
        pageController.setViewControllers([viewControllers.object(at: 0) as! UIViewController], direction: .forward, animated: false) { (b:Bool) -> Void in
            
        }
        //UIPageController必须放在Controller Container中
        self.addChildViewController(pageController)
        self.view.addSubview(pageController.view)
    }
    
    //搭建顶部切换按钮
    func layoutView(){
        // 先删除
        if buttonView != nil{
            buttonView.removeFromSuperview()
            buttonView = nil
        }
        // 再创建
        buttonView = linebutton.creatLineButton(dataArr: buttons)
        linebutton.delegate = self
        
        //buttonView.center = view.center
        self.view.addSubview(buttonView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - PageviewControllerDelegate
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
        
    }
    
    private func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        print("***********************")
//        if completed {
//             let page =  previousViewControllers[0].index(of: previousViewControllers)
//            print(previousViewControllers)
//        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        return .min
    }
    
    private func pageViewControllerSupportedInterfaceOrientations(pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func pageViewControllerPreferredInterfaceOrientationForPresentation(_ pageViewController: UIPageViewController) -> UIInterfaceOrientation {
        return .portrait
    }
    
    //MARK - PageViewControllerDataSource
    //获取当前页面的上一页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        //currentPage-=1
        //获取当前页面的索引
        let index = viewControllers.index(of: viewController)
        print(index)
//        linebutton.buttonClick(button: buttons[index] as! UIButton)
        //前一个页面
        let preIndex = index - 1
        //如果在第一个页面向右滑动则滚动到最后一页
        if preIndex < 0{
            return viewControllers[viewControllers.count-1] as? UIViewController
        }
        //判断当前索引是否大于0且少于总索引个数
        if  preIndex>=0, viewControllers.count>preIndex {
            return viewControllers[preIndex] as? UIViewController
        }else{
            return nil
        }
    }
    //获取当前页面的下一页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        //currentPage+=1
        //获取当前页面的索引
        let index = viewControllers.index(of: viewController)
        //        print(index)
        //下一个页面
        let nextIndex = index + 1
        //如果在最后页向左滑动则滚动到第一页
        if nextIndex == viewControllers.count{
            return viewControllers[0] as? UIViewController
        }
        
        //判断当前索引是否大于0且少于总索引个数
        if viewControllers.count>nextIndex{
            return viewControllers[nextIndex] as? UIViewController
        }else{
            return nil
        }
    }
    
    //#MARK - LineButtonDelegate
    //实现按钮控制页面的切换
    func clickChangePage(_ lineButton:LineButton, buttonIndex:NSInteger){
        //print(buttonIndex)
        pageController.setViewControllers([viewControllers.object(at: buttonIndex) as! UIViewController], direction: .forward, animated: false) { (b:Bool) -> Void in
            
        }
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

