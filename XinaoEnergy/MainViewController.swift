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
    
    var topView:UIView?
    var leftView: UIView?
    var minX: CGFloat?
    var midX: CGFloat?
    var maxX:CGFloat?
    var start:CGPoint?
    var move:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.yellow;
        
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
               let tabViewController =  SingleStationViewController()
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
        
        //添加侧滑页面到view上
        drawerView()
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
    
    @IBAction func openTabPage(_ sender: Any) {
        let chartsViewController = ChartsTabViewController()
        self.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(chartsViewController, animated: false)
        self.hidesBottomBarWhenPushed = false
    }
    //    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return currentPage
//    }
    
    //MARK - 打开侧滑页面
    /*
     抽屉
     */
    func drawerView(){
        self.tabBarController?.view.isMultipleTouchEnabled = true
        self.tabBarController?.view.isUserInteractionEnabled = true
        let topMake = CGRect(x: -UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        topView = UIView(frame: topMake)
        topView?.backgroundColor = UIColor.clear
        
        
        let make = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*3/5, height: UIScreen.main.bounds.height)
        leftView = UIScrollView(frame: make)
        leftView?.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.89)
        topView?.addSubview(leftView!)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.addSubview(topView!)
        
        minX = topView?.center.x//滑动view中心点 -->隐藏时中心点
        maxX = minX! + topMake.width//彻底展示时的中心点 -->显示时的中心点
        midX = (maxX!-minX!)/2 + minX!//0，显示一半时，左侧view中心点位置
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.pan(_:)))
        topView?.addGestureRecognizer(panGesture)
    }
    
    //Mark - 点击左侧按钮实现左侧页面划出
    @IBAction func openSliderBar(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.topView!.center = CGPoint(x: self.maxX!, y: self.topView!.center.y)
        }, completion: { (finish) -> Void in
            
        })
    }
    
    //Mark - 手势方法
    @objc func pan(_ pan: UIPanGestureRecognizer){
        
        switch pan.state{
            
        case UIGestureRecognizerState.began:
            print("----began----")
            start = pan.translation(in: self.view)//手指移动的实时点
            
        case UIGestureRecognizerState.changed:
            //            print("----Changed----")
            let tran = pan.translation(in: self.view)//手指移动的实时点
            //tran.x向右为正，向左为负
            let newC = (topView?.center.x)! + tran.x
            let moveX = tran.x - (start?.x)!
            let moveY = tran.y - (start?.y)!
            //保证view随着手指移动移动
            if fabs(moveX) > fabs(moveY){
                move = true
                if newC >= minX! && newC <= maxX!{
                    topView?.center = CGPoint(x: newC, y: (topView?.center.y)!)
                }
            }else{
                move = false
            }
            pan.setTranslation(CGPoint.zero, in: self.view)
        case UIGestureRecognizerState.ended:
            if move == true {
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    if self.topView!.center.x > self.minX! && self.topView!.center.x < self.midX!{//展示的view不超过view一半宽度时
                        self.topView!.center = CGPoint(x: self.minX!, y: self.topView!.center.y)
                    }else if self.topView!.center.x >= self.midX! && self.topView!.center.x < self.maxX!{//展示的view超过view一半宽度时
                        self.topView!.center = CGPoint(x: self.maxX!, y: self.topView!.center.y)
                    }
                }, completion: { (finish) -> Void in
                    
                })
            }
        default: break
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
