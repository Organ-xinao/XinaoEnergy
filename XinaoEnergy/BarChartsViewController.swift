//
//  BarChartsViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/31.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit
import Charts

class BarChartsViewController: UIViewController,ChartViewDelegate {

    let barChartView = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test4()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func test4()
    {
        self.barChartView.frame = CGRect(x: 0, y: 60, width: self.view.bounds.width, height: 600)
        self.barChartView.delegate = self
        
        self.view.addSubview(self.barChartView)
        barChartView.backgroundColor = UIColor.init(red: 230/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1.0)
        
        //基本样式
        barChartView.noDataText = "You need to provide data for the chart." //没有数据时的文字提示
        barChartView.drawValueAboveBarEnabled = true  //数值显示在柱形的上面还是下面
        barChartView.drawBarShadowEnabled = false  //是否绘制柱形的阴影背景
        
        
        //barChartView的交互设置
        self.barChartView.scaleYEnabled = false  //取消Y轴缩放
        self.barChartView.doubleTapToZoomEnabled = false   //取消双击缩放
        self.barChartView.dragEnabled = true  //启用拖拽图表
        self.barChartView.dragDecelerationEnabled = false  //拖拽后是否有惯性效果
        self.barChartView.dragDecelerationFrictionCoef = 0 //拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        
        //设置barChartView的X轴样式
        let xAxis = self.barChartView.xAxis
        xAxis.axisLineWidth = 1  //设置X轴线宽
        xAxis.labelPosition = .bottom  //X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = true   //不绘制网格线
        //xAxis.l = 4  //设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
        xAxis.labelTextColor = UIColor.brown //label文字颜色
        xAxis.labelCount = 10
        
        self.barChartView.rightAxis.enabled = false  //不绘制右边轴
        //设置左侧Y轴的样式
        let leftAxis = self.barChartView.leftAxis
        leftAxis.forceLabelsEnabled = false   //不强制绘制制定数量的label
        //leftAxis = false  //是否只显示最大值和最小值
        leftAxis.axisMinimum = -40  //设置Y轴的最小值
        leftAxis.drawZeroLineEnabled = true   //从0开始绘制
        leftAxis.axisMaximum = 105   //设置Y轴的最大值
        leftAxis.inverted = false   //是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0.5    //Y轴线宽
        leftAxis.axisLineColor =  UIColor.black  //Y轴颜色
        leftAxis.labelCount = 5
        leftAxis.forceLabelsEnabled = false
        
        //设置Y轴上标签的样式
        leftAxis.labelPosition = .outsideChart   //label位置
        leftAxis.labelTextColor = UIColor.brown   //文字颜色
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10)  //文字字体
        
        //设置Y轴上标签显示数字的格式
        let  leftFormatter = NumberFormatter()  //自定义格式
        leftFormatter.positiveSuffix = " $"  //数字后缀单位
        barChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: leftFormatter)
        
        //设置Y轴上网格线的样式
        leftAxis.gridLineDashLengths = [3.0, 3.0]   //设置虚线样式的网格线
        leftAxis.gridColor = UIColor.init(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0)  //网格线颜色
        leftAxis.gridAntialiasEnabled = true   //开启抗锯齿
        
        let limitLine = ChartLimitLine(limit: 20, label: "限制线")
        limitLine.lineWidth = 2
        limitLine.lineColor = UIColor.green
        limitLine.lineDashLengths = [5.0, 5.0]   //虚线样式
        limitLine.labelPosition = .rightTop  //位置
        leftAxis.addLimitLine(limitLine)  //添加到Y轴上
        leftAxis.drawLimitLinesBehindDataEnabled = true  //设置限制线绘制在柱形图的后面
        
        self.barChartView.legend.enabled = false  //不显示图例说明
        self.barChartView.chartDescription?.text = "" //不显示，就设为空字符串即可
        
        
        self.setData()
    }
    
    func setData()
    {
        var xVals = [String]()
        for i in 0...60
        {
            xVals.append(NSString(format: "%d年", i+1993) as String)
        }
        //chartView.xAxis.valueFormatter = KMChartAxisValueFormatter.init(xValues as NSArray)
        
        
        
        var yVals = [BarChartDataEntry]()
        for j in 0...60
        {
            let val = (Double)(arc4random_uniform(40))
            
            yVals.append(BarChartDataEntry.init(x: Double(j), y: val))
        }
        
        //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
        let set1 = BarChartDataSet(values: yVals, label: "test")
        //set1.bar = 0.2  //柱形之间的间隙占整个柱形(柱形+间隙)的比例
        set1.drawValuesEnabled = true  //是否在柱形图上面显示数值
        set1.highlightEnabled = false  //点击选中柱形图是否有高亮效果，（双击空白处取消选中）
        set1.colors = ChartColorTemplates.material()
        
        
        //将BarChartDataSet对象放入数组中
        
        
        var dataSets = [BarChartDataSet]()
        
        
        dataSets.append(set1)
        
        //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
        
        self.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xVals)
        
        let data:BarChartData = BarChartData(dataSets: dataSets)
        data.setValueFont(UIFont.init(name: "HelveticaNeue-Light", size: 10))  //文字字体
        data.setValueTextColor(UIColor.orange)  //文字颜色
        data.barWidth = 0.7
        
        //自定义数据显示格式
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        //formatter.positiveFormat = " $"
        self.barChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: formatter)
        
        
        self.barChartView.data = data
        self.barChartView.animate(xAxisDuration: 1)
        
    }
    //MARK - chartdelegate
    //点击选中柱形图时的代理方法
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
    }
    
    //没有选中柱形图时的代理方法
    func chartValueNothingSelected(_ chartView: ChartViewBase){
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    //捏合放大或缩小柱形图时的代理方法
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat)
    {
        
    }
    
    //拖拽图表时的代理方法
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat)
    {
        
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
