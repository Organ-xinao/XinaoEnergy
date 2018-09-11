//
//  UITableViewControllerCellTwo.swift
//  buttonDemo
//  二级菜单
//  Created by zx on 1976/4/1.
//  Copyright © 2018年 zx. All rights reserved.
//

import UIKit

class UITableViewControllerCellTwo: UITableViewCell {
    let mView : UIView = UIView()
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
        mView.backgroundColor = UIColor.gray
        self.contentView.addSubview(mView)
        mLabel.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width*0.7-60, height: 40)
        mLabel.font = UIFont.boldSystemFont(ofSize: 14)
        mView.addSubview(mLabel)
    }
}
