//
//  KnowLeadgeTableViewCell.swift
//  XinaoEnergy
//
//  Created by zx on 2018/8/5.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class KnowLeadgeTableViewCell: UITableViewCell {
    
    let mView : UIView = UIView()
    let mImageView : UIImageView = UIImageView()
    let mLabel : UILabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*0.7, height: 40)
        self.contentView.addSubview(mView)
        mImageView.frame = CGRect(x: 10, y: 7, width: 25, height: 25)
        mView.addSubview(mImageView)
        mLabel.frame = CGRect(x: 40, y: 0, width: UIScreen.main.bounds.width*0.7-60, height: 40)
        mLabel.font = UIFont.boldSystemFont(ofSize: 14)
        mView.addSubview(mLabel)
    }

}
