////
////  PageViewController.swift
////  XinaoEnergy
////
////  Created by jun on 2018/8/3.
////  Copyright © 2018年 jun. All rights reserved.
////
//
//import UIKit
//
//class PageViewController: UIPageViewController, UIPageViewControllerDataSource,
//UIPageViewControllerDelegate {
//
//    //页面改变的委托
//    weak var pageDelegate: PageViewControllerDelegate?
//
//    //所有页面的视图控制器
//    private(set) lazy var allViewControllers: [UIViewController] = {
//        return [self.getViewController("firstVC"),
//                self.getViewController("secondVC"),
//                self.getViewController("thirdVC")]
//    }()
//
//    //页面加载完毕
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //数据源设置
//        dataSource = self
//
//        //自身委托设置
//        delegate = self
//
//        //设置首页
//        if let firstViewController = allViewControllers.first {
//            setViewControllers([firstViewController],
//                               direction: .forward,
//                               animated: true,
//                               completion: nil)
//        }
//
//        //页面数量改变，通知委托对象
//        pageDelegate?.pageViewController(self, didUpdatePageCount: allViewControllers.count)
//    }
//
//    //根据indentifier获取Storyboard里的视图控制器
//    private func getViewController(indentifier: String) -> UIViewController {
//        return UIStoryboard(name: "Main", bundle: nil) .
//            instantiateViewController(withIdentifier: "\(indentifier)")
//    }
//
//    //获取前一个页面
//    func pageViewController(pageViewController: UIPageViewController,
//                            viewControllerBeforeViewController
//        viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = allViewControllers.index(of: viewController) else {
//            return nil
//        }
//
//        let previousIndex = viewControllerIndex - 1
//
//        guard previousIndex >= 0 else {
//            return nil
//        }
//
//        guard allViewControllers.count > previousIndex else {
//            return nil
//        }
//
//        return allViewControllers[previousIndex]
//    }
//
//    //获取后一个页面
//    func pageViewController(pageViewController: UIPageViewController,
//                            viewControllerAfterViewController
//        viewController: UIViewController) -> UIViewController? {
//        guard let viewControllerIndex = allViewControllers.index(of: viewController) else {
//            return nil
//        }
//
//        let nextIndex = viewControllerIndex + 1
//        let orderedViewControllersCount = allViewControllers.count
//
//        guard orderedViewControllersCount != nextIndex else {
//            return nil
//        }
//
//        guard orderedViewControllersCount > nextIndex else {
//            return nil
//        }
//
//        return allViewControllers[nextIndex]
//    }
//
//
//    //页面切换完毕
//    func pageViewController(pageViewController: UIPageViewController,
//                            didFinishAnimating finished: Bool,
//                            previousViewControllers: [UIViewController],
//                            transitionCompleted completed: Bool) {
//        if let firstViewController = viewControllers?.first,
//            let index = allViewControllers.index(of: firstViewController) {
//            //当前页改变，通知委托对象
//            pageDelegate?.pageViewController(self, didUpdatePageIndex: index)
//        }
//    }
//}
//
////自定义视图控制器代理协议
//protocol PageViewControllerDelegate: class {
//
//    //当页面数量改变时调用
//    func pageViewController(pageViewController: PageViewController,
//                            didUpdatePageCount count: Int)
//
//    //当前页索引改变时调用
//    func pageViewController(pageViewController: PageViewController,
//                            didUpdatePageIndex index: Int)
//}

