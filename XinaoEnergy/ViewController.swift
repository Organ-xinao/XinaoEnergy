//
//  ViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/18.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var leftView: UIView?
    var minX: CGFloat?
    var midX: CGFloat?
    var maxX:CGFloat?
    var start:CGPoint?
    var move:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //将左侧sliderView添加到页面
        //drawerView()
    }
    
    /*
     抽屉
     */
    func drawerView(){
        self.tabBarController?.view.isMultipleTouchEnabled = true
        self.tabBarController?.view.isUserInteractionEnabled = true
        let make = CGRect(x: -UIScreen.main.bounds.width*3/5, y: 0, width: UIScreen.main.bounds.width*3/5, height: UIScreen.main.bounds.height)
        leftView = UIScrollView(frame: make)
        leftView?.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.89)
        self.tabBarController?.view.addSubview(leftView!)
        minX = leftView?.center.x//滑动view中心点 -->隐藏时中心点
        maxX = minX! + make.width//彻底展示时的中心点 -->显示时的中心点
        midX = (maxX!-minX!)/2 + minX!//0，显示一半时，左侧view中心点位置
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.pan(_:)))
        self.view.addGestureRecognizer(panGesture)
    }
    
    //Mark - 点击左侧按钮实现左侧页面划出
    @IBAction func openSliderBar(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.leftView!.center = CGPoint(x: self.maxX!, y: self.leftView!.center.y)
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
            let newC = (leftView?.center.x)! + tran.x
            let moveX = tran.x - (start?.x)!
            let moveY = tran.y - (start?.y)!
            //保证view随着手指移动移动
            if fabs(moveX) > fabs(moveY){
                move = true
                if newC >= minX! && newC <= maxX!{
                    leftView?.center = CGPoint(x: newC, y: (leftView?.center.y)!)
                }
            }else{
                move = false
            }
            pan.setTranslation(CGPoint.zero, in: self.view)
        case UIGestureRecognizerState.ended:
            if move == true {
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    if self.leftView!.center.x > self.minX! && self.leftView!.center.x < self.midX!{//展示的view不超过view一半宽度时
                        self.leftView!.center = CGPoint(x: self.minX!, y: self.leftView!.center.y)
                    }else if self.leftView!.center.x >= self.midX! && self.leftView!.center.x < self.maxX!{//展示的view超过view一半宽度时
                        self.leftView!.center = CGPoint(x: self.maxX!, y: self.leftView!.center.y)
                    }
                }, completion: { (finish) -> Void in
                    
                })
            }
        default: break
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

