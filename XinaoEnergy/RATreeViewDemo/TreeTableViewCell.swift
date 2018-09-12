//
//  TreeTableViewCell.swift
//  RATreeViewExamples
//
//  Created by Rafal Augustyniak on 22/11/15.
//  Copyright © 2015 com.Augustyniak. All rights reserved.
//

import UIKit

class TreeTableViewCell : UITableViewCell {

    @IBOutlet private weak var additionalButton: UIButton!
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var customTitleLabel: UILabel!

    private var additionalButtonHidden : Bool {
        get {
            return additionalButton.isHidden;
        }
        set {
            additionalButton.isHidden = newValue;
        }
    }
    //xib对应的cell文件需要写1，2，3
    //此时执行的是2.
    //#1.
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print(#function)
    }
    //#2.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print(#function)
    }
    //#3.
    override func awakeFromNib() {
        selectedBackgroundView? = UIView()
        selectedBackgroundView?.backgroundColor = .clear
    }

    var additionButtonActionBlock : ((TreeTableViewCell) -> Void)?;

    func setup(withTitle title: String, detailsText: String, level : Int, additionalButtonHidden: Bool) {
        customTitleLabel.text = title
        detailsLabel.text = detailsText
//        self.additionalButtonHidden = additionalButtonHidden
        self.additionalButton.isHidden = true

        let backgroundColor: UIColor
        if level == 0 {
            backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        } else if level == 1 {
            backgroundColor = UIColor(red: 209.0/255.0, green: 238.0/255.0, blue: 252.0/255.0, alpha: 1.0)
        } else {
            backgroundColor = UIColor(red: 224.0/255.0, green: 248.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        }
        
        self.backgroundColor = backgroundColor
        self.contentView.backgroundColor = backgroundColor

        let left = 11.0 + 20.0 * CGFloat(level)
        self.customTitleLabel.frame.origin.x = left
        self.detailsLabel.frame.origin.x = left
    }
    
    @IBAction func additionButtonTapped(_ sender : AnyObject) -> Void {
        if let action = additionButtonActionBlock {
            action(self)
        }
    }

}
