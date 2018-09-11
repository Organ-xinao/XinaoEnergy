//
//  UICollectionViewCell.swift
//  buttonDemo
//
//  Created by zx on 1976/4/1.
//  Copyright © 2018年 zx. All rights reserved.
//

import UIKit
class MyUICollectionViewCell : UICollectionViewCell {
    
    var clabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clabel.frame = self.bounds
        clabel.backgroundColor = UIColor.orange
        clabel.layer.borderColor = UIColor.red.cgColor
        clabel.layer.borderWidth = 2
        clabel.textAlignment = .center
        clabel.textColor = UIColor.white
        self.addSubview(clabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
