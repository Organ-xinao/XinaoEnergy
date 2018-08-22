//
//  ChangeNumberPasswordViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/8/20.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class ChangeNumberPasswordViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var oldTextField: UITextField!
    
    @IBOutlet weak var newTextField: UITextField!
    
    @IBOutlet weak var confrimTextField: UITextField!
    
    var oldHave:Bool = false
    
    var newHave:Bool = false
    
    var confrimHave:Bool = false
    
    var rightBar:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftBar:UIBarButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backTolast))
        self.navigationItem.leftBarButtonItem = leftBar
        
        rightBar = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.done, target: self, action: #selector(changePassword))
        rightBar.isEnabled = false
        rightBar.tintColor = UIColor.blue
        self.navigationItem.rightBarButtonItem = rightBar
        
        oldTextField.delegate = self
        newTextField.delegate = self
        confrimTextField.delegate = self
        
        oldTextField.tag = 0
        newTextField.tag = 1
        confrimTextField.tag = 2
        
        //设置清除按钮的显示样式
        oldTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        newTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        confrimTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func backTolast (){
        //由于本页面是push进来的所以用pop返回
        self.navigationController?.popViewController(animated: true)
    }
    @objc func changePassword () {
        if newTextField.text != confrimTextField.text{
//            let alertview:UItoa =
        }
    }
    
    //textField - editChange判断按钮的状态
   
    @IBAction func checkOld(_ sender: Any) {
        let oldText = sender as! UITextField
        print(oldText.text as Any)
        if oldText.text != ""{
            oldHave = true
            if newHave == true, confrimHave == true{
                rightBar.isEnabled = true
            }else{
                rightBar.isEnabled = false
            }
        }else{
            oldHave = false
            rightBar.isEnabled = false
        }
    }
    
    @IBAction func checkNew(_ sender: Any) {
        let newText = sender as! UITextField
        print(newText.text as Any)
        if newText.text != ""{
            newHave = true
            if oldHave == true, confrimHave == true{
                rightBar.isEnabled = true
            }else{
                rightBar.isEnabled = false
            }
        }else{
            newHave = false
            rightBar.isEnabled = false
        }
    }
    
    
    @IBAction func checkConfrim(_ sender: Any) {
        let confrimText = sender as! UITextField
        print(confrimText.text as Any)
        if confrimText.text != ""{
            confrimHave = true
            if newHave == true, oldHave == true{
                rightBar.isEnabled = true
            }else{
                rightBar.isEnabled = false
            }
        }else{
            confrimHave = false
            rightBar.isEnabled = false
        }
    }
    
    //#MARK - textFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField){
        //更改return键
        newTextField.returnKeyType = UIReturnKeyType.next
        
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textField.tag == 1{
            confrimTextField.becomeFirstResponder()
            return false
        }else{
            textField.resignFirstResponder()
            return true
        }
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
