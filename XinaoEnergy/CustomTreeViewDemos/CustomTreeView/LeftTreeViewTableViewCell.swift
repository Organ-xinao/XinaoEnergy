
//
//  LeftTreeViewTableViewCell.swift
//  XinaoEnergy
//
//  Created by jun on 2018/8/29.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class LeftTreeViewTableViewCell: UITableViewCell {
    var cellModel:LeftCellCodeModel!
    var rightImage:UIImageView!
    var titleLabel:UILabel!
    
    //纯代码写cell，以下为需要写的
    //此时执行的是1
    //1.
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //print(#function)
        self.setupContentView()
    }
    //2. 刚开始会报错，后来加了一段这个东西
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //print(#function)
        fatalError("init(coder:) has not been implemented")
    }
    //3.
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //print(#function)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    ///添加内容视图
    private func setupContentView() {
        rightImage = UIImageView.init(frame: CGRect.zero)
        //self.addSubview(rightImage)
        titleLabel = UILabel.init(frame: CGRect.zero)
        self.addSubview(titleLabel)
    }
    
    //更改位置
    func setupCustomView(withTitle title: String, level : Int) -> Void{
        //rightImage.frame = CGRect(x: 80, y: 10, width: 20, height: 20)
        titleLabel.frame = CGRect(x: 20+20*level, y: 10, width: 100, height: 20)
    }

}
