//
//  MainViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/20.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    
    var pageController:UIPageViewController!
    var currentPage:Int = 0
    var viewControllers = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.yellow;

        // Do any additional setup after loading the view.
        //初始化
        //transitionStyle:转换样式，有pageCurl和scroll两种
        //navigationOrientation:导航方向，有Horizontal和Vertical两种
        //options: UIPageViewControllerOptionSpineLocationKey---书脊的位置
        //         UIPageViewControllerOptionInterPageSpacingKey---每页的间距
        pageController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionSpineLocationKey:NSNumber(value: 10)])
        pageController.delegate = self;//设置delegate,提供展示相关的信息和接收手势发起的转换的通知
        pageController.dataSource = self;//设置datasource,提供展示的内容
        
        currentPage = 0
        //初始化要展示的Controller,自定义
        for index in 0...9 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let pViewController = storyboard.instantiateViewController(withIdentifier: "StationViewController") as! StationViewController
            if index == 3{
               let tabViewController = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
                viewControllers.add(tabViewController)
            }else{
               viewControllers.add(pViewController)
            }
            
            pViewController.pageText = "全新第\(index+1)页"
        }
        //展示之前进行初始化第一个Controller, 单个显示放一个,两个显示则放两个,和样式有关
        pageController.setViewControllers([viewControllers.object(at: 0) as! UIViewController], direction: .forward, animated: false) { (b:Bool) -> Void in
            
        }
        //UIPageController必须放在Controller Container中
        self.addChildViewController(pageController)
        self.view.addSubview(pageController.view)
        //先移除通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"initToMain"), object: nil)
        // 接收通知
        //object必须为空（否则监听不了），暂时不清楚这个参数的意义
        NotificationCenter.default.addObserver(self, selector: #selector(Myfunc(notification:)), name: NSNotification.Name(rawValue:"initToMain"), object: nil)
        currentPage = 0
    }
    
    @objc func Myfunc(notification: NSNotification) {
        
//        let getStr = notification.object as! String //这里以通知内容为字符串类型为例
//
//        print("收到通知："+getStr)
        //展示之前进行初始化第一个Controller, 单个显示放一个,两个显示则放两个,和样式有关
        pageController.setViewControllers([viewControllers.object(at: 0) as! UIViewController], direction: .forward, animated: false) { (b:Bool) -> Void in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK - PageviewControllerDelegate
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [AnyObject]) {
        
    }
    
    private func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        
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
        currentPage-=1
        //获取当前页面的索引
        let index = viewControllers.index(of: viewController)
        print(index)
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
        currentPage+=1
        //获取当前页面的索引
        let index = viewControllers.index(of: viewController)
//        print(index)
        //前一个页面
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
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageController.viewControllers!.count
    }
    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return currentPage
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
