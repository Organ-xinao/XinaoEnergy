//
//  RealTimeProvideCollectionViewCell.swift
//  XinaoEnergy
//
//  Created by jun on 2018/8/28.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class RealTimeProvideCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var unit: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.06)
        self.alpha = 0.78
        self.layer.borderWidth = 2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(red: 10/255, green: 34/255, blue: 76/255, alpha: 1).cgColor
    }
    
}
