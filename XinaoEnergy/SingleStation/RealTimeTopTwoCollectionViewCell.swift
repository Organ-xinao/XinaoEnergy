//
//  RealTimeTopTwoCollectionViewCell.swift
//  XinaoEnergy
//
//  Created by jun on 2018/9/5.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class RealTimeTopTwoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.06)
        self.alpha = 0.78
        self.layer.borderWidth = 2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(red: 10/255, green: 34/255, blue: 76/255, alpha: 1).cgColor
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
}
