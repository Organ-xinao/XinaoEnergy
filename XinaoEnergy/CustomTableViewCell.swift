//
//  CustomTableViewCell.swift
//  XinaoEnergy
//
//  Created by zx on 1976/4/1.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell{


    @IBOutlet weak var styleImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 设置cell 圆角
       
    }

    override func setSelected(_ selected:Bool,animated:Bool){
        super.setSelected(selected,animated:animated)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
