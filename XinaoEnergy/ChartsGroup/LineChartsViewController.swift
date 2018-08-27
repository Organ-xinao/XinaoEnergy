//
//  PersonViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/20.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit
import Charts.Swift

class LineChartsViewController: UIViewController,ChartViewDelegate {
    let lineChartView = LineChartView()
    var lineCircleColors:[UIColor]!=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test2()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //charts折线图研究，等Xcode更新后再继续
    func test2()
    {
        
        lineChartView.frame = CGRect(x: 20, y: 60, width: self.view.bounds.width - 40, height: pageVCHeight-120)
        self.view.addSubview(lineChartView)
        lineChartView.delegate = self
        
        lineChartView.backgroundColor = UIColor.white//(red: 13/255.0, green: 21/255.0, blue: 40/255.0, alpha: 1)
        lineChartView.noDataText = "暂无数据"
        
        //设置交互样式
        lineChartView.scaleYEnabled = false //取消Y轴缩放
        lineChartView.doubleTapToZoomEnabled = true //双击缩放
        lineChartView.dragEnabled = true //启用拖动手势
        lineChartView.dragDecelerationEnabled = true //拖拽后是否有惯性效果
        lineChartView.dragDecelerationFrictionCoef = 0.9  //拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        
        //设置X轴样式
        let xAxis = lineChartView.xAxis
        xAxis.axisLineWidth = 1.0/UIScreen.main.scale //设置X轴线宽
        xAxis.labelPosition = .bottom //X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = false;//不绘制网格线
        xAxis.spaceMin = 4;//设置label间隔
        xAxis.axisMinimum = 0
        xAxis.axisLineColor = UIColor(white: 1, alpha: 0.1605)
        xAxis.labelTextColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)//label文字颜色
        
        //设置Y轴样式
        lineChartView.rightAxis.enabled = false  //不绘制右边轴
        let leftAxis = lineChartView.leftAxis
        leftAxis.labelCount = 16 //Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        leftAxis.forceLabelsEnabled = false //不强制绘制指定数量的label
        leftAxis.axisMinimum = 0 //设置Y轴的最小值
        leftAxis.drawZeroLineEnabled = true //从0开始绘制
        //leftAxis.axisMaximum = 1000 //设置Y轴的最大值
        leftAxis.inverted = false //是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 1.0/UIScreen.main.scale //设置Y轴线宽
        leftAxis.axisLineColor = UIColor(white: 1, alpha: 0.1605)//Y轴颜色
        //leftAxis.valueFormatter = NumberFormatter()//自定义格式
        //leftAxis.s  //数字后缀单位
        leftAxis.labelPosition = .outsideChart//label位置
        leftAxis.labelTextColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)//文字颜色
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10)//文字字体
        
        
        //设置网格样式
        leftAxis.gridLineDashLengths = [3.0,3.0]  //设置虚线样式的网格线
        leftAxis.gridColor = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 0.1) //网格线颜色
        leftAxis.gridAntialiasEnabled = true //开启抗锯齿
        
        
        //添加限制线
        let litmitLine = ChartLimitLine(limit: 260, label: "限制线")
        litmitLine.lineWidth = 2
        litmitLine.lineColor = UIColor.green
        litmitLine.lineDashLengths = [5.0,5.0] //虚线样式
        litmitLine.labelPosition = .rightTop  // 限制线位置
        litmitLine.valueTextColor = UIColor.brown
        litmitLine.valueFont = UIFont.systemFont(ofSize: 12)
        leftAxis.addLimitLine(litmitLine)
        leftAxis.drawLimitLinesBehindDataEnabled = true  //设置限制线绘制在折线图的后面
        
        //设置折线图描述及图例样式
        lineChartView.chartDescription?.text = "折线图" //折线图描述
        lineChartView.chartDescription?.textColor = UIColor.cyan  //描述字体颜色
        lineChartView.legend.form = .line  // 图例的样式
        lineChartView.legend.formSize = 20  //图例中线条的长度
        lineChartView.legend.textColor = UIColor.darkGray
        
        
        //设置折线图的数据
        let xValues = ["x1","x2","x3","x4","x5","x6","x7","x8","x9","x10","x11","x12","x13","x14","x15","x16","x17","x18","x19","x20","x21","x22","x23","x24","x25","x26"]
        var newxValues:[String] = []
        for xValue in xValues{
            let newValue = xValue.components(separatedBy: "x")[1].appending("日")
            newxValues.append(newValue)
        }
        //        lineChartView.xAxis.valueFormatter = KMChartAxisValueFormatter.init(xValues as NSArray)
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: newxValues)
        //ineChartView.xAxis.labelCount = 12
        //lineChartView.leftAxis.valueFormatter = KMChartAxisValueFormatter.init()
        let leftValueFormatter = NumberFormatter()  //自定义格式
        leftValueFormatter.positiveSuffix = "亿"  //数字后缀单位
        
        lineChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: leftValueFormatter)
        
        var yDataArray1 = [ChartDataEntry]()
        for i in 0...xValues.count-1 {
            let y = arc4random()%500
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            
            yDataArray1.append(entry)
            
            lineCircleColors.append(UIColor(red: 59/255, green: 169/255, blue: 255/255, alpha: 1))
        }
        
        
        let set1 = LineChartDataSet.init(values: yDataArray1, label: "test1")
        set1.colors = [UIColor(red: 59/255, green: 169/255, blue: 255/255, alpha: 1)]
        set1.drawCirclesEnabled = true //是否绘制转折点
        //set1.setCircleColor(UIColor(red: 59/255, green: 169/255, blue: 255/255, alpha: 1))//转折点圆圈的颜色
        set1.circleColors = lineCircleColors//为选中点变色做准备
        set1.circleHoleColor = UIColor.white //转折点内部的颜色
        set1.lineWidth = 1
        set1.circleRadius = 5//外圆半径
        set1.circleHoleRadius = 4//内圆半径
        set1.mode = .cubicBezier  //设置曲线是否平滑
        set1.drawValuesEnabled = false //设置是否显示折线上的数据
        
        //开启填充色绘制
        set1.drawFilledEnabled = true
        //渐变颜色数组
        let gradientColors = [UIColor(red: 59/255, green: 169/255, blue: 255/255, alpha: 1).cgColor, UIColor.white.cgColor] as CFArray
        //每组颜色所在位置（范围0~1)
        let colorLocations:[CGFloat] = [1.0, 0.0]
        //生成渐变色
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                       colors: gradientColors, locations: colorLocations)
        //将渐变色作为填充对象s
        set1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        
        var yDataArray2 = [ChartDataEntry]();
        for i in 0...(xValues.count-1) {
            let y = arc4random()%500+1
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            
            yDataArray2.append(entry);
        }
        let set2 = LineChartDataSet.init(values: yDataArray2, label: "test2")
        set2.colors = [UIColor.green]
        set2.drawCirclesEnabled = false
        set2.lineWidth = 1.0
        
        let data = LineChartData.init(dataSets: [set1])
        
        lineChartView.data = data
        //lineChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInBack)
        lineChartView.animate(xAxisDuration: 1)  //设置动画时间
        
    }
    
    func showMarkerView(value:String)
    {
        let marker = MarkerView.init(frame: CGRect(x: 20, y: 20, width: 60, height: 20))
        marker.chartView = self.lineChartView
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        label.text = value
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = UIColor.gray
        label.textAlignment = .center
        marker.addSubview(label)
        self.lineChartView.marker = marker
    }
    
    //MARK - chartdelegate
    //因为转折点内圈颜色是一起设定的，所以无法更改内部颜色
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        self.showMarkerView(value: "\(entry.y)")
        //将选中的数据点的颜色改成黄色
        var chartDataSet = LineChartDataSet()
        chartDataSet = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        let values = chartDataSet.values
        let index = values.index(where: {$0.x == highlight.x})  //获取索引
        chartDataSet.circleColors = lineCircleColors //还原
        chartDataSet.circleColors[index!] = .orange
        
        //重新渲染表格
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
    
    //折线上的点取消选中回调
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        //print("取消选中的数据")
        
        //还原所有点的颜色
        var chartDataSet = LineChartDataSet()
        chartDataSet = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        chartDataSet.circleColors = lineCircleColors
        
        //重新渲染表格
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
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

