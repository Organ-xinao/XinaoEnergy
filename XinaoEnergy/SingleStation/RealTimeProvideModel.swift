//
//  RealTimeProvideModel.swift
//  XinaoEnergy
//
//  Created by jun on 2018/8/28.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class RealTimeProvideModel: NSObject {
//    var id:String
    var image:String
    var title:String
    var value:String
    var unit:String
    init( image:String, title:String, value:String, unit:String) {
//        self.id = id
        self.image = image
        self.title = title
        self.value = value
        self.unit = unit
    }
}
