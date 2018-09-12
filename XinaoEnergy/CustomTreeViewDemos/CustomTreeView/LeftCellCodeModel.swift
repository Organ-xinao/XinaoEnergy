//
//  LeftCellCodeModel.swift
//  XinaoEnergy
//
//  Created by jun on 2018/9/3.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class LeftCellCodeModel: NSObject {
    var superId:Int
    var myId:Int
    var myLevel:Int
    var hasChildren:Bool
    var isOpen:Bool
    var title:String
    var rightImg:UIImage
    init(superId:Int, myId:Int, myLevel:Int,hasChildren:Bool, isOpen:Bool, title:String, image:UIImage) {
        self.superId = superId
        self.myId = myId
        self.myLevel = myLevel
        self.hasChildren = hasChildren
        self.isOpen = isOpen
        self.title = title
        self.rightImg = image
    }
}
