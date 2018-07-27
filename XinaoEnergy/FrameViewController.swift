//
//  FrameViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/19.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit
var fristSelected:Bool = true
class FrameViewController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //该过程也可在根页面里面写
        //避免受默认的半透明颜色影响，关闭
        self.tabBar.isTranslucent = false
        //可以在这里设置tabBar item选中的颜色
        //self.tabBarController?.tabBar.tintColor = UIColor.red
        var items: [UITabBarItem] = (self.tabBar.items)!
        //设置默认图片直接在IB添加新tabBar的时候Image选择好，这里是修改未被选中时的图片，针对未选中一值为灰色的解决方法
        //通过name获取图片
        //设置image，同理可设置selectedImage
        let tabbar0Image = UIImage(named: "main")
        let tabbar1Image = UIImage(named: "knowleadge")
        let tabbar2Image = UIImage(named: "idea")
        let tabbar3Image = UIImage(named: "person")

        items[0].image = tabbar0Image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        items[1].image = tabbar1Image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        items[2].image = tabbar2Image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        items[3].image = tabbar3Image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        fristSelected = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //监听tabbar的操作
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        print(item.tag)
        
        if item.tag == 0 {
            if fristSelected == false {
                fristSelected = true
                sendNotification()
            }
        }else{
            fristSelected = false
        }
    }
    
    func sendNotification()
    {
        // 发送通知
        // 无参数
        // NSNotificationCenter.defaultCenter().postNotificationName("ChangeBackgroundColor", object: nil, userInfo: nil)
        
        // 带参数
//        let number = arc4random() % 1000
//        let numberString = ("\(number)" as String)
//        let dict = ["number":numberString];
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "initToMain"), object: "wo shi tongzhi xinxi")
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
