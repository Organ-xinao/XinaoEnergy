//
//  UITableViewControllerCellOne.swift
//  buttonDemo
//  一级菜单
//  Created by zx on 1976/4/1.
//  Copyright © 2018年 zx. All rights reserved.
//

import UIKit

class UITableViewControllerCellOne: UIView,UIGestureRecognizerDelegate {
    let mLabel : UILabel = UILabel()
    let mView : UIView = UIView()
    var isSelected : Bool = false

    var callBack = {(index : Int,isSelected : Bool)->Void in
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        mView.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width, height: 35)
        mLabel.frame = CGRect(x: 0, y: 0, width: mView.frame.width, height: mView.frame.height)
        mLabel.font = UIFont.boldSystemFont(ofSize: 14)
        mView.addSubview(mLabel)
        self.addSubview(mView)
        let gestureOption = UITapGestureRecognizer()
        gestureOption.delegate = self
        gestureOption.isEnabled = true
        gestureOption.addTarget(self, action: #selector(touched))
        mView.addGestureRecognizer(gestureOption)
    }

    @objc func touched(){
        //setViewStatus()
        callBack(self.tag,isSelected)
    }
}
