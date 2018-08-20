//
//  IdeaViewController.swift
//  XinaoEnergy
//
//  Created by jun on 2018/7/20.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit
import CocoaAsyncSocket
import SwiftyJSON

class IdeaViewController: UIViewController, GCDAsyncSocketDelegate{

    @IBOutlet weak var serveripInput: UITextField!
    @IBOutlet weak var msgInput: UITextField!
    @IBOutlet weak var conBtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var msgView: UITextView!
    
    var sendArray:[String:Any]!
    
    //UInt16 -- > Int32
    //Convert.ToInt32(number)
    let serverPort: UInt16 = UInt16(truncating: 8088)
    
    var clientSocket:GCDAsyncSocket!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let localIp:String = UserDefaults.standard.object(forKey: "localIP") as? String {
            serveripInput.text = localIp
        }else{
            return
        }
        sendBtn.isEnabled = false // Socket未连接成功时发送按钮不能用
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 连接服务器按钮事件
    @IBAction func conBtnClick(_ sender: AnyObject) {
        if serveripInput.text?.isEmpty == false { // 如果IP地址不为空则开始连接Socket
            clientSocket = GCDAsyncSocket()
            clientSocket.delegate = self
            clientSocket.delegateQueue = DispatchQueue.global()
            do {
                try clientSocket.connect(toHost: serveripInput.text!, onPort: serverPort)
                print(serveripInput.text!+":"+String(serverPort))
            } catch {
                print("try connect error: \(error)")
                conBtn.backgroundColor = UIColor.red
            }
        } else {
            msgView.insertText("IP地址不能为空！\n")
        }
    }
    
    //连接成功的回调
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) -> Void {
        print("connect success")
        print(sock)
        /*
         1. 主线程中使用async可以和后台线程一起并行执行任务
         2. 主线程中使用sync则只能串行执行任务, 当前线程被卡住直到串行任务完成才继续
         */
         DispatchQueue.main.async {
            UserDefaults.standard.set(self.serveripInput.text, forKey: "localIP")
            self.sendBtn.isEnabled = true // 连接成功后发送按钮设为可用
        }
        clientSocket.readData(withTimeout: -1, tag: 0)
    }
    
    //断开链接时的回调
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) -> Void {
        print("connect error: \(String(describing: err))")
    }
    
    //成功发送消息的回调
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) -> Void {
//        clientSocket.readData(to: GCDAsyncSocket.crlfData(), withTimeout: -1, tag: 0)
        print("你发送了消息")
        DispatchQueue.main.async {
            let showStr: NSMutableString = NSMutableString()
            showStr.append(self.msgView.text)
            showStr.append("我:" + (self.sendArray["msg"] as! String))
            showStr.append("\r\n")
            self.msgView.text = showStr as String
        }
    }
    
    //收到消息的回调
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) -> Void {
//        let orignalJson = JSON.init(data: data)
//        print(orignalJson)
        let readClientDataString: NSString? = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
        
        print("---Data Recv---")
        print(readClientDataString  ?? "default msg")
        
        //判断是否可以转换json
        if !JSONSerialization.isValidJSONObject(readClientDataString ?? " ") {
            print("不能转化")
            // 2、主界面UI显示数据
            DispatchQueue.main.async {
                let showStr: NSMutableString = NSMutableString()
                showStr.append(self.msgView.text)
                showStr.append("服务端返回：" + (readClientDataString! as String))
                showStr.append("\r\n")
                self.msgView.text = showStr as String
            }
        } else {
            //1.可以将data转为json对象的，将data转为json对象
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any] {
                print("jsonDic:",json)
                //json串
                let jsonString = json["data"] as? String
                let jsonData:Data = jsonString!.data(using: .utf8)!
                //如果data中是标准json串时
                if let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [String : Any] {
                    print(dict)
                    DispatchQueue.main.async {
                        let showStr: NSMutableString = NSMutableString()
                        showStr.append(self.msgView.text)
                        showStr.append((dict["userName"] as! String) + ":" + (dict["msg"] as! String))
                        showStr.append("\r\n")
                        self.msgView.text = showStr as String
                    }
                }else{
                    //当data里面的数据不能被解析时
                    DispatchQueue.main.async {
                        let showStr: NSMutableString = NSMutableString()
                        showStr.append(self.msgView.text)
                        showStr.append((json["IP"] as! String) + "返回：" + (json["data"]! as! String))
                        showStr.append("\r\n")
                        self.msgView.text = showStr as String
                    }
                }
                
            } else {
                // 2、主界面UI显示数据
                DispatchQueue.main.async {
                    let showStr: NSMutableString = NSMutableString()
                    showStr.append(self.msgView.text)
                    showStr.append("服务端返回：" + (readClientDataString! as String))
                    showStr.append("\r\n")
                    self.msgView.text = showStr as String
                }
            }
        }
        // 3、处理请求，返回数据给服务端OK
//        let serviceStr: NSMutableString = NSMutableString()
//        serviceStr.append("OK")
//        serviceStr.append("\r\n")
//        clientSocket.write(serviceStr.data(using: String.Encoding.utf8.rawValue)!, withTimeout: -1, tag: 0)
       
        // 4、每次读完数据后，都要调用一次监听数据的方法
        clientSocket.readData(withTimeout: -1, tag: 0)
    }
    
    // 发送消息按钮事件
    @IBAction func sendBtnClick(_ sender: AnyObject) {
        if msgInput.text?.isEmpty == false {
            // 1.如果消息不为空则发送
            let serviceStr: NSMutableString = NSMutableString()
            serviceStr.append(self.msgInput.text!)
            serviceStr.append("\r\n")
            
            //1.2传更多的信息过去
            sendArray = ["fromUserName":"admin","toUserName":"YYNetWork","msg":self.msgInput.text!]
            //json 的可用性判断
            if !JSONSerialization.isValidJSONObject(sendArray) {
                print("不能转化")
                return
            }
            //json 字符串转换为data
            guard let data = try? JSONSerialization.data(withJSONObject: sendArray, options: .prettyPrinted) else { return }
            //data 转为字符串
//            let jsonstr = String(data: data, encoding: .utf8)
//            print(jsonstr ?? "ds")
            
            clientSocket.write(data, withTimeout: -1, tag: 0)
        }
    }
}
