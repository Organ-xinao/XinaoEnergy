//
//  CustomSearchBar.swift
//  XinaoEnergy
//
//  Created by jun on 2018/9/14.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    var preferredFont: UIFont!
    var preferredTextColor: UIColor!
    
    //实现自定义初始化构造器,设置大小，字体，文本颜色，样式等基本属性
    init(frame: CGRect,font: UIFont, textColor: UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        preferredFont = font
        preferredTextColor = textColor
        //设置为prominent样式并且需要设置isTranslucent为false，为了searchBar和earch field都不透明。
        searchBarStyle = UISearchBarStyle.prominent
        isTranslucent = false
        
        //注意：search bar并不是一个单一的控件，它是textfield的一部分。相反，search bar有一个UIView类型的子视图，该子视图有两个非常重要的子视图，一个是search field是UITextField类型的子类，另一个是search field的背景view。我们可以使用如下操作，打印子视图内容：
        print(subviews[0].subviews)
    }
    
    //自定义子视图必须实现该方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //建立一个辅助函数，获取search field在search bar子视图中的位置
    func indexOfSearchFieldInSubviews() ->Int!{
        var index: Int!
        let searchBarView = subviews[0]
        
        for  i in 0..<searchBarView.subviews.count {
            if searchBarView.subviews[i].isKind(of: UITextField.self){
                index = i
                break
            }
        }
        return index
    }
    
    //实现draw方法
    override func draw(_ rect: CGRect) {
        //获取search field在search bar子视图中的位置
        if let index = indexOfSearchFieldInSubviews(){
            //获得search field
            let searchField: UITextField = subviews[0].subviews[index] as! UITextField
            //设置search field的大小
            searchField.frame = CGRect(x: 5.0, y: 5.0, width: frame.size.width - 10.0, height: frame.size.height - 10.0)
            //设置字体和文本颜色
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            //设置search field的背景颜色
            searchField.backgroundColor = barTintColor
        }
        
        //在search bar的底部绘制一条细线,使用CAShapeLayer和UIBezierPath进行绘制
        let startPoint = CGPoint(x: 0.0, y: frame.size.height)
        let endPoint = CGPoint(x: frame.size.width, y: frame.size.height)
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = preferredTextColor.cgColor
        shapeLayer.lineWidth = 2.5
        
        layer.addSublayer(shapeLayer)
        super.draw(rect)
    }
}


