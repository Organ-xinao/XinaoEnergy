//
//  LineButton.swift
//  XinaoEnergy
//
//  Created by jun on 2018/8/2.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class LineButton: NSObject {
    
    // button数组
    var buttonArr:NSMutableArray = []
    // 创建view方法
    func creatLineButton(dataArr:NSMutableArray) ->UIView {
        // 最底层容器view
        let myView = UIView(frame: CGRect(x:20,y:84,width:kScreenWidth-40,height:40))
        
        // 计算按钮大小
        let gap = 10
        let btnWidth = (myView.width - CGFloat(gap*(dataArr.count-1)))/CGFloat(dataArr.count)
        for index in 0..<dataArr.count {
            // 定义button
            let tabBtn = UIButton(frame:CGRect(x:CGFloat(index)*(10.0+btnWidth), y:0, width:btnWidth, height:40))
            // 赋值
            tabBtn.setTitle(dataArr[index] as? String, for: UIControlState.normal)
            tabBtn.backgroundColor = UIColor.black
            tabBtn.setTitleColor(UIColor.init(red:255/255,green:255/255,blue:255/255,alpha:0.41), for: UIControlState.normal)
            tabBtn.setTitleColor(UIColor.white, for: UIControlState.selected)
            tabBtn.layer.borderWidth=1
            tabBtn.layer.cornerRadius = 20
            
            // 同一个点击方法 根据传值和数组区分
            tabBtn.addTarget(self, action: #selector(buttonClick(button:)), for: UIControlEvents.touchUpInside)
            // 添加到view上
            myView.addSubview(tabBtn)
            // 加入button数组
            buttonArr.add(tabBtn)
        }
        // 返回值
        return myView
    }
    // 按钮点击事件
    @objc func buttonClick(button:UIButton){
        for b in buttonArr{
            // 遍历按钮数组,如果相同就改成选中状态,不相同就取消选中状态
            if (b as! UIButton) == button{
                (b as! UIButton).isSelected = true
                (b as! UIButton).backgroundColor = UIColor.init(red: 37/255, green: 44/255, blue: 61/255, alpha: 1)
            }else{
                (b as! UIButton).isSelected = false
                (b as! UIButton).backgroundColor = UIColor.black
            }
        }
    }
}
