//
//  PieChartsViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/31.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit
import Charts

class PieChartsViewController: UIViewController {

    let pieChartView = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test3()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test3()
    {
        pieChartView.frame = CGRect(x: 20, y: 60, width: self.view.bounds.width - 40, height: pageVCHeight-120)
        self.view.addSubview(pieChartView)
        pieChartView.backgroundColor = UIColor.init(red: 230/255, green: 253/255.0, blue: 253/255.0, alpha: 1)
        pieChartView.setExtraOffsets(left: 40, top: 10, right: 40, bottom: 30)  //设置这块饼的位置
        pieChartView.chartDescription?.text = "饼状图示例" //描述文字
        pieChartView.chartDescription?.font = UIFont.systemFont(ofSize: 12)
        pieChartView.chartDescription?.textColor = UIColor.black
        
        pieChartView.usePercentValuesEnabled = true  //转化为百分比
        //pieChartView.dragDecelerationEnabled = false //把拖拽效果关了
        pieChartView.drawEntryLabelsEnabled = true //显示区块文本
        pieChartView.entryLabelFont = UIFont.systemFont(ofSize: 10) //区块文本的字体
        pieChartView.entryLabelColor = UIColor.white
        pieChartView.drawSlicesUnderHoleEnabled = true
        
        pieChartView.drawHoleEnabled = true  //这个饼是空心的
        pieChartView.holeRadiusPercent = 0.382  //空心半径黄金比例
        pieChartView.holeColor = UIColor.white //空心颜色设置为白色
        pieChartView.transparentCircleRadiusPercent = 0.5  //半透明空心半径
        
        pieChartView.drawCenterTextEnabled = true //显示中心文本
        pieChartView.centerText = "饼状图"  //设置中心文本,你也可以设置富文本`centerAttributedText`
        
        //图例样式设置
        pieChartView.legend.maxSizePercent = 1  //图例的占比
        pieChartView.legend.form = .circle //图示：原、方、线
        pieChartView.legend.formSize = 8 //图示大小
        pieChartView.legend.formToTextSpace = 4 //文本间隔
        pieChartView.legend.font = UIFont.systemFont(ofSize: 8)
        pieChartView.legend.textColor = UIColor.gray
        pieChartView.legend.horizontalAlignment = .left
        pieChartView.legend.verticalAlignment = .top
        
        self.pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInBack)
        
        self.drawPieChartView()
        
    }
    
    func drawPieChartView()
    {
        let titles = ["红","黄","蓝色","橙","绿"]
        let yData = [20,30,10,40,60]
        var yVals = [PieChartDataEntry]()
        
        for i in 0...titles.count - 1
        {
            let entry = PieChartDataEntry.init(value: Double(yData[i]), label: titles[i])
            yVals.append(entry)
        }
        
        let dataSet = PieChartDataSet.init(values: yVals, label:"test")
        dataSet.colors = [UIColor.red,UIColor.yellow,UIColor.blue,UIColor.orange,UIColor.green] //设置名称和数据的位置 都在内就没有折线了
        dataSet.xValuePosition = .insideSlice
        dataSet.yValuePosition = .outsideSlice
        dataSet.sliceSpace = 1 //相邻块的距离
        dataSet.selectionShift = 6.66  //选中放大半径
        
        //指示折线样式
        dataSet.valueLinePart1OffsetPercentage = 0.8 //折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
        dataSet.valueLinePart1Length = 0.8 //折线中第一段长度占比
        dataSet.valueLinePart2Length = 0.4 //折线中第二段长度最大占比
        dataSet.valueLineWidth = 1 //折线的粗细
        dataSet.valueLineColor = UIColor.brown //折线颜色
        
        let data = PieChartData.init(dataSets: [dataSet])
        //data.setValueFormatter(KMChartAxisValueFormatter.init()) //格式化值（添加个%）
        data.setValueFont(UIFont.systemFont(ofSize: 10.0))
        data.setValueTextColor(UIColor.lightGray)
        pieChartView.data = data
        
        
        
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
