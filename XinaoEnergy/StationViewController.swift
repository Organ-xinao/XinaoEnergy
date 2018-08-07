//
//  StationViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/24.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit
import Neon

class StationViewController: BaseViewController,UIScrollViewDelegate {

    @IBOutlet weak var numberLabel: UILabel!
    var pageText:String?
    //MARK:拷贝自zx
    let containerView : UIView = UIView()
    var contentHeader : UIView!
    //MARK:实时供能
    var contentView : UIView!
    var contentLeftView : UIView!
    var contentRightView : UIView!
    var leftBorder : UILabel!
    var viewLabel : UILabel!
    var leftNumView : UILabel!
    var leftOfView : UILabel!
    var rightborder : UILabel!
    var rightView : UILabel!
    var rightNumView : UILabel!
    var rightOfView : UILabel!
    var floatViewOfLeft1 : UILabel!
    var floatViewOfLeft2 : UILabel!
    var floatViewOfLeft3 : UILabel!
    //MARK:今日供能
    var contentViewOfRectangle : UIView!
    //MARK:今日耗能
    var contentViewOfConsumption : UIView!
    //MARK:滚动控件
    var scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numberLabel.text = self.pageText
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.delegate = self
        //var screenFrame = UIScreen.main.bounds
        //        let screenWidth = screenFrame.size.width
        //        let screenHeight = screenFrame.size.height
        scrollView.frame = CGRect(x: 0.0, y: (self.navigationController?.navigationBar.frame.size.height)!+UIApplication.shared.statusBarFrame.height, width: view.frame.width, height: UIScreen.main.bounds.height - (navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height - (tabBarController?.tabBar.frame.height)!)
        scrollView.backgroundColor = UIColor.black
        //MARK:点击状态栏返回到顶部
        scrollView.scrollsToTop = true
        //MARK:是否显示滚动条
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(containerView)
        //        containerView.backgroundColor = UIColor.black
        
        contentHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 120))
        containerView.addSubview(contentHeader)
        contentHeader.backgroundColor = UIColor(patternImage: UIImage(named: "Group 8")!)
        
        self.view.addSubview(scrollView)

        //        let floatViewOfRight = UIView(frame: CGRect(x: 0, y: 25, width: contentRightView.frame.size.width, height: 50))
        //
        //        contentRightView.addSubview(floatViewOfRight)
        //        floatViewOfRight.backgroundColor = UIColor.init(patternImage: UIImage(named: "Group 8")!)
        //        floatViewOfRight.layer.borderColor = UIColor.red.cgColor
        //        floatViewOfRight.layer.borderWidth = 2
        //        let floatViewOfRight = UIImageView(image: UIImage(named: "Group 8"))
        //        contentRightView.addSubview(floatViewOfRight)
        
        //        //定义渐变的颜色（2种彩虹色）
        //        let startColor = UIColor.lightGray
        //        let endColor = UIColor.black
        //        let gradientColors = [startColor.cgColor,endColor.cgColor]
        //
        //        //定义每种颜色所在的位置
        //        let gradientLocations:[NSNumber] = [0.0, 1.0]
        //
        //        //创建CAGradientLayer对象并设置参数
        //        let gradientLayer = CAGradientLayer()
        //        gradientLayer.colors = gradientColors
        //        gradientLayer.locations = gradientLocations
        //
        //        //设置渲染的起始结束位置（横向渐变）
        //        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        //        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        //
        //        //设置其CAGradientLayer对象的frame，并插入anchorView的layer
        //        gradientLayer.frame = self.anchorView.frame
        //        self.anchorView.layer.insertSublayer(gradientLayer, at: 0)
        //
        
        layoutFrame()
    }
    //MARK:开始布局
    func layoutFrame(){
        contentLeftView = UIView(frame: CGRect(x: 0, y: 5, width: view.frame.size.width/2, height: 120))
        //        contentLeftView.backgroundColor = UIColor(red: 23, green: 145, blue: 123, alpha: 1)
        contentRightView = UIView(frame: CGRect(x: view.frame.size.width/2, y: 5, width: view.frame.size.width/2, height: 120))
        
        contentHeader.addSubview(contentLeftView)
        contentHeader.addSubview(contentRightView)
        
        //--------------------------------
        leftBorder = UILabel(frame: CGRect(x: 5, y: 0, width: 2, height: 20))
        leftBorder.backgroundColor = UIColor(red: 52/255, green: 186/255, blue: 253/255, alpha: 1)
        contentLeftView.addSubview(leftBorder)
        
        let widthOfViewLabel = super.getLabelWidth(str: "机组总量", font: font14, height: 20)+5
        viewLabel = UILabel(frame: CGRect(x: 9, y: 0, width: widthOfViewLabel, height: 20))
        viewLabel.text = "机组总量"
        viewLabel.textColor = UIColor.white
        viewLabel.textAlignment = .center
        viewLabel.font = UIFont.boldSystemFont(ofSize: 14)
        contentLeftView.addSubview(viewLabel)
        
        
        let leftNum = super.getLabelWidth(str: "10", font: font14, height: 20)+5
        leftNumView = UILabel(frame: CGRect(x: widthOfViewLabel+9, y: 0, width: leftNum, height: 20))
        
        leftNumView.text = "10"
        leftNumView.textColor = UIColor(red: 52/255, green: 186/255, blue: 253/255, alpha: 1)
        leftNumView.font = UIFont.boldSystemFont(ofSize: 14)
        contentLeftView.addSubview(leftNumView)
        
        leftOfView = UILabel(frame: CGRect(x: widthOfViewLabel+9+leftNum, y: 0, width: 15, height: 20))
        leftOfView.text = "台"
        leftOfView.textColor = UIColor.white
        leftOfView.textAlignment = .left
        leftOfView.font = UIFont.boldSystemFont(ofSize: 14)
        contentLeftView.addSubview(leftOfView)
        
        //-----------------------------------
        rightborder = UILabel(frame: CGRect(x: 5, y: 0, width: 2, height: 20))
        rightborder.backgroundColor = UIColor(red: 52/255, green: 186/255, blue: 253/255, alpha: 1)
        contentRightView.addSubview(rightborder)
        
        let rightViewWith = super.getLabelWidth(str: "总装机容量", font: font14, height: 20)+5
        rightView = UILabel(frame: CGRect(x: 9, y: 0, width: rightViewWith, height: 20))
        rightView.text = "总装机容量"
        rightView.textColor = UIColor.white
        rightView.font = UIFont.boldSystemFont(ofSize: 14)
        contentRightView.addSubview(rightView)
        
        let rightNumWidth = super.getLabelWidth(str: "1200", font: font14, height: 20)+5
        rightNumView = UILabel(frame: CGRect(x: 9+rightViewWith, y: 0, width: rightNumWidth, height: 20))
        rightNumView.text = "1200"
        rightNumView.textColor = UIColor(red: 52/255, green: 186/255, blue: 253/255, alpha: 1)
        rightNumView.font = UIFont.boldSystemFont(ofSize: 14)
        rightNumView.textAlignment = .left
        contentRightView.addSubview(rightNumView)
        
        rightOfView = UILabel(frame: CGRect(x: 9+rightViewWith+rightNumWidth, y: 0, width: 25, height: 20))
        rightOfView.text = "kw"
        rightOfView.textColor = UIColor.white
        rightOfView.font = UIFont.boldSystemFont(ofSize: 14)
        rightOfView.textAlignment = .left
        contentRightView.addSubview(rightOfView)
        
        floatViewOfLeft1 = UILabel(frame: CGRect(x: 5, y: 25, width: contentLeftView.frame.size.width/2-10, height: 25))
        floatViewOfLeft1.backgroundColor = UIColor(red: 7/255, green: 25/255, blue: 44/255, alpha: 0.5)
        floatViewOfLeft1.text = "启动中8台"
        floatViewOfLeft1.textAlignment = .center
        floatViewOfLeft1.font = UIFont.boldSystemFont(ofSize: 18)
        floatViewOfLeft1.textColor = UIColor.white
        
        contentLeftView.addSubview(floatViewOfLeft1)
        floatViewOfLeft1.font = UIFont.boldSystemFont(ofSize: 14)
        floatViewOfLeft1.layer.cornerRadius = 5
        floatViewOfLeft1.layer.borderWidth = 1
        floatViewOfLeft1.layer.borderColor = UIColor(red: 8/255, green: 26/255, blue: 62/255, alpha: 1).cgColor
        
        floatViewOfLeft2 = UILabel(frame: CGRect(x: contentLeftView.frame.size.width/2, y: 25, width: contentLeftView.frame.size.width/2-5, height: 25))
        floatViewOfLeft2.text = "运行中2台"
        floatViewOfLeft2.textAlignment = .center
        floatViewOfLeft2.font = UIFont.boldSystemFont(ofSize: 18)
        floatViewOfLeft2.textColor = UIColor.white
        floatViewOfLeft2.backgroundColor = UIColor(red: 7/255, green: 25/255, blue: 44/255, alpha: 0.5)
        contentLeftView.addSubview(floatViewOfLeft2)
        floatViewOfLeft2.font = UIFont.boldSystemFont(ofSize: 14)
        floatViewOfLeft2.layer.cornerRadius = 5
        floatViewOfLeft2.layer.borderWidth = 1
        floatViewOfLeft2.layer.borderColor = UIColor(red: 8/255, green: 26/255, blue: 62/255, alpha: 1).cgColor
        
        floatViewOfLeft3 = UILabel(frame: CGRect(x: 5, y: 55, width: contentLeftView.frame.size.width/2-10, height: 25))
        floatViewOfLeft3.text = "停机1台"
        floatViewOfLeft3.textAlignment = .center
        floatViewOfLeft3.font = UIFont.boldSystemFont(ofSize: 18)
        floatViewOfLeft3.textColor = UIColor.white
        floatViewOfLeft3.backgroundColor = UIColor(red: 7/255, green: 25/255, blue: 44/255, alpha: 0.5)
        contentLeftView.addSubview(floatViewOfLeft3)
        floatViewOfLeft3.font = UIFont.boldSystemFont(ofSize: 14)
        floatViewOfLeft3.layer.cornerRadius = 5
        floatViewOfLeft3.layer.borderWidth = 1
        floatViewOfLeft3.layer.borderColor = UIColor(red: 8/255, green: 26/255, blue: 62/255, alpha: 1).cgColor
        
        //MARK:实时供能
        contentView = UIView(frame : CGRect(x: 0, y: 121, width: view.frame.size.width, height: 125))
        containerView.addSubview(contentView)
        let contentLabel1 = UILabel(frame: CGRect(x: 5, y: 0, width: 60, height: 20))
        contentLabel1.text = "实时供能"
        contentLabel1.textColor = UIColor(red: 134/255, green: 138/255, blue: 147/255, alpha: 1)
        contentLabel1.font = UIFont.boldSystemFont(ofSize: 18)
        contentView.addSubview(contentLabel1)
        contentLabel1.font = UIFont.boldSystemFont(ofSize: 14)
        let options : [Int : [String:String]] = [1:["leftName":"发电总功率","image":"Group 3 Copy1","setFontSize":"18","fontSize":"14","textAlignment":"center","RightName":"425.09 kW","x":"5","y":"20"],
                   2:["leftName":"产蒸汽流量","image":"产蒸汽 copy","setFontSize":"18","fontSize":"14","textAlignment":"center","RightName":"5.01 t/h","x":String(Int(contentView.frame.size.width/2)+2),"y":"20"],3:["leftName":"制热功率","image":"产热 copy","setFontSize":"18","fontSize":"14","textAlignment":"center","RightName":"0.00 kW","x":"5","y":"75"],4:["leftName":"制冷功率","image":"产冷 copy","setFontSize":"18","fontSize":"14","textAlignment":"center","RightName":"567.0 kW","x":String(Int(contentView.frame.size.width/2)+2),"y":"75"]]
        setContentView(options:options)
        //MARK:今日供能
        contentViewOfRectangle = UIView(frame: CGRect(x: 5, y: 250, width: view.frame.size.width-10, height: 130))
        containerView.addSubview(contentViewOfRectangle)
        let contentOfLeftAndTopTitle = UILabel(frame: CGRect(x: 0, y: 5, width: contentViewOfRectangle.frame.size.width/2, height: 20))
        contentOfLeftAndTopTitle.textAlignment = NSTextAlignment.left
        contentOfLeftAndTopTitle.text = "今日供能"
        contentOfLeftAndTopTitle.font = UIFont.boldSystemFont(ofSize: 18)
        contentOfLeftAndTopTitle.textColor = UIColor(red: 134/255, green: 138/255, blue: 147/255, alpha: 1)
        contentViewOfRectangle.addSubview(contentOfLeftAndTopTitle)
        contentOfLeftAndTopTitle.font = UIFont.boldSystemFont(ofSize: 14)
        
        let contentViewOfRectangleContent = UIView(frame:CGRect(x:0,y:30,width:contentViewOfRectangle.frame.size.width,height:100))
        contentViewOfRectangle.addSubview(contentViewOfRectangleContent)
        contentViewOfRectangleContent.backgroundColor = UIColor(red: 12/255, green: 17/255, blue: 30/255, alpha: 1)
        contentViewOfRectangleContent.layer.borderColor = UIColor(red: 17/255, green: 35/255, blue: 65/255, alpha: 1).cgColor
        contentViewOfRectangleContent.layer.borderWidth = 1
        
        let contentOfLeftAndTopText = UILabel(frame: CGRect(x: 5, y: 0, width: contentViewOfRectangleContent.frame.size.width/5, height: 50))
        contentOfLeftAndTopText.text = "总发电量"
        contentOfLeftAndTopText.textColor = UIColor.white
        contentOfLeftAndTopText.font = UIFont.boldSystemFont(ofSize: 18)
        contentOfLeftAndTopText.textAlignment = .left
        contentViewOfRectangleContent.addSubview(contentOfLeftAndTopText)
        contentOfLeftAndTopText.font = UIFont.boldSystemFont(ofSize: 14)
        
        let contentOfLeftAndTopValue = UILabel(frame: CGRect(x: contentViewOfRectangleContent.frame.size.width/5, y: 0, width: contentViewOfRectangleContent.frame.size.width/2-(contentViewOfRectangleContent.frame.size.width/5), height: 50))
        contentOfLeftAndTopValue.text = "5425.18 kWh"
        contentOfLeftAndTopValue.textColor = UIColor(red: 40/255, green: 153/255, blue: 255/255, alpha: 1)
        contentOfLeftAndTopValue.font = UIFont.boldSystemFont(ofSize: 18)
        contentOfLeftAndTopValue.textAlignment = .center
        contentViewOfRectangleContent.addSubview(contentOfLeftAndTopValue)
        contentOfLeftAndTopValue.font = UIFont.boldSystemFont(ofSize: 14)
        
        let RightBorder = UILabel(frame: CGRect(x: contentViewOfRectangleContent.frame.size.width/2, y: 0, width: 1, height: 100))
        RightBorder.backgroundColor = UIColor(red: 10/255, green: 20/255, blue: 42/255, alpha: 1)
        contentViewOfRectangleContent.addSubview(RightBorder)
        
        let contentOfRightAndTopTitle = UILabel(frame: CGRect(x: contentViewOfRectangleContent.frame.size.width/2+5, y: 0, width: contentViewOfRectangleContent.frame.size.width/5, height: 50))
        contentOfRightAndTopTitle.text = "产蒸汽量"
        contentOfRightAndTopTitle.textColor = UIColor.white
        contentOfRightAndTopTitle.textAlignment = .left
        contentOfRightAndTopTitle.font = UIFont.boldSystemFont(ofSize: 18)
        contentViewOfRectangleContent.addSubview(contentOfRightAndTopTitle)
        contentOfRightAndTopTitle.font = UIFont.boldSystemFont(ofSize: 14)
        
        let contentOfRightAndTopValue = UILabel(frame: CGRect(x: contentViewOfRectangleContent.frame.size.width/2 + contentViewOfRectangleContent.frame.size.width/5, y: 0, width: contentViewOfRectangleContent.frame.size.width - contentViewOfRectangleContent.frame.size.width/2 - contentViewOfRectangleContent.frame.size.width/5, height: 50))
        contentOfRightAndTopValue.text = "1425.01 t"
        contentOfRightAndTopValue.textColor = UIColor(red:51/255,green:192/255,blue:215/255,alpha:1)
        contentOfRightAndTopValue.font = UIFont.boldSystemFont(ofSize:18)
        contentOfRightAndTopValue.textAlignment = .center
        contentViewOfRectangleContent.addSubview(contentOfRightAndTopValue)
        contentOfRightAndTopValue.font = UIFont.boldSystemFont(ofSize:14)
        
        let contentOfLeftAndBottomText = UILabel(frame: CGRect(x: 5, y: 50, width: contentViewOfRectangleContent.frame.size.width/5, height: 50))
        contentOfLeftAndBottomText.text = "制热量"
        contentOfLeftAndBottomText.textColor = UIColor.white
        contentOfLeftAndBottomText.font = UIFont.boldSystemFont(ofSize: 18)
        contentOfLeftAndBottomText.textAlignment = .left
        contentViewOfRectangleContent.addSubview(contentOfLeftAndBottomText)
        contentOfLeftAndBottomText.font = UIFont.boldSystemFont(ofSize: 14)
        
        let contentOfLeftAndBottomValue = UILabel(frame: CGRect(x: contentViewOfRectangleContent.frame.size.width/5, y: 50, width: contentViewOfRectangleContent.frame.size.width/2-(contentViewOfRectangleContent.frame.size.width/5), height: 50))
        contentOfLeftAndBottomValue.text = "5425.18 MJ"
        contentOfLeftAndBottomValue.textColor = UIColor(red: 206/255, green: 146/255, blue: 64/255, alpha: 1)
        contentOfLeftAndBottomValue.font = UIFont.boldSystemFont(ofSize: 18)
        contentOfLeftAndBottomValue.textAlignment = .center
        contentViewOfRectangleContent.addSubview(contentOfLeftAndBottomValue)
        contentOfLeftAndBottomValue.font = UIFont.boldSystemFont(ofSize: 14)
        
        let buttomBorder = UILabel(frame: CGRect(x: 0, y: 50, width: contentViewOfRectangleContent.frame.size.width, height: 1))
        buttomBorder.backgroundColor = UIColor(red: 10/255, green: 20/255, blue: 42/255, alpha: 1)
        contentViewOfRectangleContent.addSubview(buttomBorder)
        
        let contentOfRightAndBottomTitle = UILabel(frame: CGRect(x: contentViewOfRectangleContent.frame.size.width/2+5, y: 50, width: contentViewOfRectangleContent.frame.size.width/5, height: 50))
        contentOfRightAndBottomTitle.text = "制冷量"
        contentOfRightAndBottomTitle.textColor = UIColor.white
        contentOfRightAndBottomTitle.textAlignment = .left
        contentOfRightAndBottomTitle.font = UIFont.boldSystemFont(ofSize: 18)
        contentViewOfRectangleContent.addSubview(contentOfRightAndBottomTitle)
        contentOfRightAndBottomTitle.font = UIFont.boldSystemFont(ofSize: 14)
        
        let contentOfRightAndButtomValue = UILabel(frame: CGRect(x: contentViewOfRectangleContent.frame.size.width/2 + contentViewOfRectangleContent.frame.size.width/5, y: 50, width: contentViewOfRectangleContent.frame.size.width - contentViewOfRectangleContent.frame.size.width/2 - contentViewOfRectangleContent.frame.size.width/5, height: 50))
        contentOfRightAndButtomValue.text = "5425.18 MJ"
        contentOfRightAndButtomValue.textColor = UIColor(red: 40/255, green: 153/255, blue: 255/255,alpha:1)
        contentOfRightAndButtomValue.font = UIFont.boldSystemFont(ofSize:18)
        contentOfRightAndButtomValue.textAlignment = .center
        contentViewOfRectangleContent.addSubview(contentOfRightAndButtomValue)
        contentOfRightAndButtomValue.font = UIFont.boldSystemFont(ofSize:14)
        
        // MARK:今日耗能
        contentViewOfConsumption = UIView(frame: CGRect(x: 5, y: 385, width: view.frame.width-10, height: 80))
        containerView.addSubview(contentViewOfConsumption)
        
        let consumptionTitle = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: 20))
        consumptionTitle.text = "今日耗能"
        consumptionTitle.textColor = UIColor(red: 134/255, green: 138/255, blue: 147/255, alpha: 1)
        consumptionTitle.font = UIFont.boldSystemFont(ofSize: 18)
        contentViewOfConsumption.addSubview(consumptionTitle)
        consumptionTitle.font = UIFont.boldSystemFont(ofSize: 14)
        
        let consumptionContent = UIView(frame: CGRect(x: 0, y: 25, width: view.frame.width-10, height: 60))
        consumptionContent.backgroundColor = UIColor(red: 13/255, green: 21/255, blue: 40/255, alpha: 1)
        consumptionContent.layer.borderColor = UIColor(red: 17/255, green: 35/255, blue: 65/255, alpha: 1).cgColor
        consumptionContent.layer.borderWidth = 1
        contentViewOfConsumption.addSubview(consumptionContent)
        
        let consumptionContentLabelViewTitle = UILabel(frame: CGRect(x: 5, y: 5, width: view.frame.width/3, height: 20))
        consumptionContentLabelViewTitle.text = "当日耗气量"
        consumptionContentLabelViewTitle.textColor = UIColor.white
        consumptionContentLabelViewTitle.font = UIFont.boldSystemFont(ofSize: 18)
        consumptionContentLabelViewTitle.textAlignment = NSTextAlignment.left
        consumptionContent.addSubview(consumptionContentLabelViewTitle)
        consumptionContentLabelViewTitle.font = UIFont.boldSystemFont(ofSize: 14)
        
        let consumptionContentLabelViewVal = UILabel(frame: CGRect(x: 5, y: 25, width: view.frame.width/3, height: 20))
        consumptionContentLabelViewVal.text = "4845.28 Nm³"
        consumptionContentLabelViewVal.textColor = UIColor(red: 219/255, green: 213/255, blue: 128/255, alpha: 1)
        consumptionContentLabelViewVal.font = UIFont.boldSystemFont(ofSize: 18)
        consumptionContentLabelViewVal.textAlignment = .left
        consumptionContent.addSubview(consumptionContentLabelViewVal)
        consumptionContentLabelViewVal.font = UIFont.boldSystemFont(ofSize: 14)
        
        let consumptionContentLabelViewTitle2 = UILabel(frame: CGRect(x: 5+view.frame.width/3, y: 5, width: view.frame.width/3, height: 20))
        consumptionContentLabelViewTitle2.text = "当日耗水量"
        consumptionContentLabelViewTitle2.textColor = UIColor.white
        consumptionContentLabelViewTitle2.font = UIFont.boldSystemFont(ofSize: 18)
        consumptionContentLabelViewTitle2.textAlignment = NSTextAlignment.left
        consumptionContent.addSubview(consumptionContentLabelViewTitle2)
        consumptionContentLabelViewTitle2.font = UIFont.boldSystemFont(ofSize: 14)
        
        let consumptionContentLabelViewVal2 = UILabel(frame: CGRect(x: 5+view.frame.width/3, y: 25, width: view.frame.width/3, height: 20))
        consumptionContentLabelViewVal2.text = "7897.09 t"
        consumptionContentLabelViewVal2.textColor = UIColor(red: 85/255, green: 206/255, blue: 165/255, alpha: 1)
        consumptionContentLabelViewVal2.font = UIFont.boldSystemFont(ofSize: 18)
        consumptionContentLabelViewVal2.textAlignment = .left
        consumptionContent.addSubview(consumptionContentLabelViewVal2)
        consumptionContentLabelViewVal2.font = UIFont.boldSystemFont(ofSize: 14)
        
        //MARK:添加按钮
        cameraButtonMethods()
        containerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 510)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 510)
        print(view.frame.height)
        print(scrollView.frame.height)
        
    }
    func cameraButtonMethods(){
        var cameraButton = UIButton()
        cameraButton = UIButton(type: UIButtonType.custom)
        cameraButton.frame = CGRect(x: 20, y: 470, width: 100, height: 40)
        cameraButton.setTitle("去调用相机", for: UIControlState.normal)
        cameraButton.backgroundColor = UIColor.blue
        cameraButton.addTarget(self, action: #selector(btnEvent), for: .touchUpInside)
        containerView.addSubview(cameraButton)
    }
    
    @objc func btnEvent(){
        self.navigationController?.pushViewController(CameraViewController(), animated: false)
    }
    // MARK:设置实时供能动态生成的模块
    func setContentView(options : [Int:[String:String]]){
        for (i,value) in options{
            if i == 1{
                let contentView1 = UIView(frame: CGRect(x: Int(value["x"]!)!, y: Int(value["y"]!)!, width: Int(self.view.frame.size.width/2-7), height: 50))
                let imageView = UIImageView(image: UIImage(named:value["image"]!))
                let imageOfSubView = UIView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
                imageOfSubView.addSubview(imageView)
                contentView1.addSubview(imageOfSubView)
                let underContentofLeftWidth = super.getLabelWidth(str: value["leftName"]!, font: UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!)), height: 20)+5
                let underContentOfLeft = UILabel(frame: CGRect(x: 35, y: 5, width: underContentofLeftWidth, height: 20))
                underContentOfLeft.text = value["leftName"]
                underContentOfLeft.textColor = UIColor(red: 234/255, green: 235/255, blue: 235/255, alpha: 1)
                underContentOfLeft.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!))
                underContentOfLeft.textAlignment = NSTextAlignment.left
                
                contentView1.addSubview(underContentOfLeft)
                underContentOfLeft.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["fontSize"]!)!))
                let underContentOfRightWidth = super.getLabelWidth(str: value["RightName"]!, font: UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!)), height: 20)+5
                let underContentOfRight = UILabel(frame: CGRect(x: contentView1.frame.size.width/5*2
                    , y: contentView1.frame.size.height-25, width: underContentOfRightWidth-20, height: 20))
                underContentOfRight.text = value["RightName"]
                underContentOfRight.textColor = UIColor.white
                underContentOfRight.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!))
                underContentOfRight.textAlignment = NSTextAlignment.center
                contentView1.addSubview(underContentOfRight)
                underContentOfRight.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["fontSize"]!)!))
                contentView1.backgroundColor = UIColor(red: 12/255, green: 17/255, blue: 30/255, alpha: 1)
                contentView1.layer.borderColor = UIColor(red: 8/255, green: 26/255, blue: 62/255, alpha: 1).cgColor
                contentView1.layer.borderWidth = 1
                
                self.contentView.addSubview(contentView1)
            }else if i == 2{
                let contentView2 = UIView(frame: CGRect(x: Int(value["x"]!)!, y: Int(value["y"]!)!, width: Int(self.view.frame.size.width/2-7), height: 50))
                let imageView = UIImageView(image: UIImage(named:value["image"]!))
                let imageOfSubView = UIView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
                imageOfSubView.addSubview(imageView)
                contentView2.addSubview(imageOfSubView)
                let underContentofLeftWidth = super.getLabelWidth(str: value["leftName"]!, font: UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!)), height: 20)+5
                let underContentOfLeft = UILabel(frame: CGRect(x: 35, y: 5, width: underContentofLeftWidth, height: 20))
                underContentOfLeft.text = value["leftName"]
                underContentOfLeft.textColor = UIColor(red: 234/255, green: 235/255, blue: 235/255, alpha: 1)
                underContentOfLeft.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!))
                underContentOfLeft.textAlignment = NSTextAlignment.left
                
                contentView2.addSubview(underContentOfLeft)
                underContentOfLeft.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["fontSize"]!)!))
                let underContentOfRightWidth = super.getLabelWidth(str: value["RightName"]!, font: UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!)), height: 20)+10
                let underContentOfRight = UILabel(frame: CGRect(x: contentView2.frame.size.width/5*2
                    , y: contentView2.frame.size.height-25, width: underContentOfRightWidth-20, height: 20))
                underContentOfRight.text = value["RightName"]
                underContentOfRight.textColor = UIColor.white
                underContentOfRight.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!))
                underContentOfRight.textAlignment = NSTextAlignment.center
                contentView2.addSubview(underContentOfRight)
                underContentOfRight.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["fontSize"]!)!))
                contentView2.backgroundColor = UIColor(red: 12/255, green: 17/255, blue: 30/255, alpha: 1)
                contentView2.layer.borderColor = UIColor(red: 8/255, green: 26/255, blue: 62/255, alpha: 1).cgColor
                contentView2.layer.borderWidth = 1
                
                contentView.addSubview(contentView2)
            }else if i == 3{
                let contentView3 = UIView(frame: CGRect(x: Int(value["x"]!)!, y: Int(value["y"]!)!, width: Int(self.view.frame.size.width/2-7), height: 50))
                let imageView = UIImageView(image: UIImage(named:value["image"]!))
                let imageOfSubView = UIView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
                imageOfSubView.addSubview(imageView)
                contentView3.addSubview(imageOfSubView)
                let underContentofLeftWidth = super.getLabelWidth(str: value["leftName"]!, font: UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!)), height: 20)+5
                let underContentOfLeft = UILabel(frame: CGRect(x: 35, y: 5, width: underContentofLeftWidth, height: 20))
                underContentOfLeft.text = value["leftName"]
                underContentOfLeft.textColor = UIColor(red: 234/255, green: 235/255, blue: 235/255, alpha: 1)
                underContentOfLeft.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!))
                underContentOfLeft.textAlignment = NSTextAlignment.left
                
                contentView3.addSubview(underContentOfLeft)
                underContentOfLeft.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["fontSize"]!)!))
                let underContentOfRightWidth = super.getLabelWidth(str: value["RightName"]!, font: UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!)), height: 20)+10
                let underContentOfRight = UILabel(frame: CGRect(x: contentView3.frame.size.width/5*2
                    , y: contentView3.frame.size.height-25, width: underContentOfRightWidth-20, height: 20))
                underContentOfRight.text = value["RightName"]
                underContentOfRight.textColor = UIColor.white
                underContentOfRight.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!))
                underContentOfRight.textAlignment = NSTextAlignment.center
                contentView3.addSubview(underContentOfRight)
                underContentOfRight.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["fontSize"]!)!))
                contentView3.backgroundColor = UIColor(red: 12/255, green: 17/255, blue: 30/255, alpha: 1)
                contentView3.layer.borderColor = UIColor(red: 8/255, green: 26/255, blue: 62/255, alpha: 1).cgColor
                contentView3.layer.borderWidth = 1
                
                contentView.addSubview(contentView3)
            }else{
                let contentView4 = UIView(frame: CGRect(x: Int(value["x"]!)!, y: Int(value["y"]!)!, width: Int(self.view.frame.size.width/2-7), height: 50))
                let imageView = UIImageView(image: UIImage(named:value["image"]!))
                let imageOfSubView = UIView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
                imageOfSubView.addSubview(imageView)
                contentView4.addSubview(imageOfSubView)
                let underContentofLeftWidth = super.getLabelWidth(str: value["leftName"]!, font: UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!)), height: 20)+5
                let underContentOfLeft = UILabel(frame: CGRect(x: 35, y: 5, width: underContentofLeftWidth, height: 20))
                underContentOfLeft.text = value["leftName"]
                underContentOfLeft.textColor = UIColor(red: 234/255, green: 235/255, blue: 235/255, alpha: 1)
                underContentOfLeft.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!))
                underContentOfLeft.textAlignment = NSTextAlignment.left
                
                contentView4.addSubview(underContentOfLeft)
                underContentOfLeft.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["fontSize"]!)!))
                let underContentOfRightWidth = super.getLabelWidth(str: value["RightName"]!, font: UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!)), height: 20)+5
                let underContentOfRight = UILabel(frame: CGRect(x: contentView4.frame.size.width/5*2
                    , y: contentView4.frame.size.height-25, width: underContentOfRightWidth-20, height: 20))
                underContentOfRight.text = value["RightName"]
                underContentOfRight.textColor = UIColor.white
                underContentOfRight.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["setFontSize"]!)!))
                underContentOfRight.textAlignment = NSTextAlignment.center
                contentView4.addSubview(underContentOfRight)
                underContentOfRight.font = UIFont.boldSystemFont(ofSize: CGFloat(Int(value["fontSize"]!)!))
                contentView4.backgroundColor = UIColor(red: 12/255, green: 17/255, blue: 30/255, alpha: 1)
                contentView4.layer.borderColor = UIColor(red: 8/255, green: 26/255, blue: 62/255, alpha: 1).cgColor
                contentView4.layer.borderWidth = 1
                
                contentView.addSubview(contentView4)
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
