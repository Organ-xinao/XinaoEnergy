//
//  AppDelegate.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/18.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var controllers:[UIViewController] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //MARK - 纯代码编写tabbar起始页
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        //self.window!.backgroundColor = UIColor.white;
//
//        let vcArray:[UIViewController] = [MainViewController(), KnowLeadgeViewController(), IdeaViewController(), PersonViewController()]
//        let titleArray = [("消息", "main"), ("联系人", "idea"), ("新看点", "knowleadge"), ("动态", "person")]
//        for (index, vc) in vcArray.enumerated() {
//            //将为选中图片设置为默认图片，这样就不是系统默认的灰色了
//            var nav = vcArray[index]
//            if index != 3 {
//                nav = UINavigationController.init(rootViewController: vc)
//                // 需要title的情况
//                nav.title = titleArray[index].0
//            }
//
//            nav.tabBarItem.title = titleArray[index].0
//            // 不需要title的情况，需要调整image位置
//            nav.tabBarItem.tag = index
//            nav.tabBarItem.image = UIImage(named: (titleArray[index].1))?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//
//            controllers.append(nav)
//        }
//
//        let mainTabContrainer = FrameViewController()
//        mainTabContrainer.tabBar.isTranslucent = false
//        mainTabContrainer.tabBar.tintColor = UIColor.init(red: 53.0/255.0, green: 169.0/255.0, blue: 255.0/255.0, alpha: 1.0)
//        mainTabContrainer.viewControllers = controllers
//        self.window?.rootViewController = mainTabContrainer
//        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

