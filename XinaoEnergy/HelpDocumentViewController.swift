//
//  HelpDocumentViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/8/8.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit
import WebKit

class HelpDocumentViewController: UIViewController,WKNavigationDelegate, WKUIDelegate {
    
    private var myWKWebView = WKWebView()
    private var progressView = UIProgressView()
    var open_url:String = "https://www.baidu.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "帮助文档"
        //action后的方法名如果加“：”则方法里面需要传button；如果没有“：”，则空着即可
        //只有文字
//        let item = UIBarButtonItem(title: "done", style: UIBarButtonItemStyle.done, target: self, action: #selector(HelpDocumentViewController.backToparent))
//        self.navigationItem.leftBarButtonItem = item
        
        //设置只有图片显示
        let leftBarBtn = UIBarButtonItem(title: "", style: .plain, target: self,
                                         action: #selector(backItemPressed))
        leftBarBtn.image = UIImage(named: "back")
        //用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10
        spacer.tintColor = UIColor.black
        leftBarBtn.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
        
        //传统webview的使用
//        let myWebView:UIWebView = UIWebView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
//        myWebView.backgroundColor = UIColor.white
//
//        let path = Bundle.main.path(forResource: "咕咚APP截图操作", ofType: "pdf")
//        let url = NSURL(fileURLWithPath: path!)
//        let urlRequest = NSURLRequest(url: url as URL)
//
//        myWebView.loadRequest(urlRequest as URLRequest)
//        self.view.addSubview(myWebView)
        
        //wkwebView的使用
        myWKWebView = WKWebView.init(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-64))//将navigationbar的高度减去，不然会显示不全
        myWKWebView.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false//具体什么效果未知
        
        myWKWebView.navigationDelegate = self
        myWKWebView.uiDelegate = self;
        
        //加载本地文件
//        let wkPath = Bundle.main.path(forResource: "咕咚APP截图操作", ofType: "pdf")
//        let wkUrl = NSURL(fileURLWithPath: wkPath!)
//        let wkUrlRequest = NSURLRequest(url: wkUrl as URL)
//        myWKWebView.load(wkUrlRequest as URLRequest)
        
        //加载网页
        let url = URL(string: open_url)
        let request = URLRequest(url: url!)
        myWKWebView.load(request)
        
        self.view.addSubview(myWKWebView)
        
        myWKWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        progressView = UIProgressView(frame: CGRect(x: 0, y: 44-2, width: UIScreen.main.bounds.size.width, height: 2))
        progressView.trackTintColor = UIColor.white
        progressView.progressTintColor = UIColor.orange
        self.navigationController?.navigationBar.addSubview(progressView)
        
        

    }
    
    @objc func backItemPressed() {
        if myWKWebView.canGoBack {
            myWKWebView.goBack()
        }else{
            if let nav = self.navigationController {
//                nav.popViewController(animated: true)
                nav.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = myWKWebView.estimatedProgress == 1
            progressView.setProgress(Float(myWKWebView.estimatedProgress), animated: true)
            //progresss实时打印
//            print(myWKWebView.estimatedProgress)
        }
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
        self.navigationItem.title = webView.title
    }
    
    //离开页面，移除进度条监听
    deinit {
        print("con is deinit")
        myWKWebView.removeObserver(self, forKeyPath: "estimatedProgress")
        progressView.reloadInputViews()
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
