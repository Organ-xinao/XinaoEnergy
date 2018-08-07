//
//  CameraViewController.swift
//  XinaoEnergy
//
//  Created by zx on 1976/4/1.
//  Copyright © 2018年 jun. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var cameraView = CameraView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        cameraView = CameraView(frame: UIScreen.main.bounds)
        self.view.addSubview(cameraView)
        cameraView.cameraButton.addTarget(self, action: #selector(CameraViewController.cameraEvent), for: .touchUpInside)
        cameraView.photoButton.addTarget(self, action: #selector(CameraViewController.photoEvent), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func cameraEvent(){
        let pickerCamera = UIImagePickerController()
        pickerCamera.delegate = self
        self.present(pickerCamera,animated:true,completion: nil)
    }
    @objc func photoEvent(){
        let pickerPhoto = UIImagePickerController()
        pickerPhoto.sourceType = .camera
        pickerPhoto.delegate = self
        self.present(pickerPhoto,animated:true,completion:nil)
    }
    
    func imagePickerController(_ picker:UIImagePickerController,didFinishPickingMediaWithInfo info:[String:Any]){
        let imagePickerc = info[UIImagePickerControllerOriginalImage] as!UIImage
        cameraView.image.image = imagePickerc
        self.dismiss(animated:true,completion:nil)
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
