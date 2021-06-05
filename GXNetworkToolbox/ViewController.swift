//
//  ViewController.swift
//  GXNetworkToolbox
//
//  Created by 葛昭友 on 2018/9/24.
//  Copyright © 2018年 ChowQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var fileHandle: FileHandle!
    private var appInfoFile: String!

    // rtmp url
    let cmdLineText = CustomField()
    let copyRight = UITextField()
    let logView = UITextView()
    let backgroundLayer = CAGradientLayer()
    
    var logString: String = "gggggg" {
        didSet {
            DispatchQueue.main.async(execute: {
                self.logView.text = self.logString
            })
        }
    }
    
    // publish button
    var startBtn: UIButton = {
        let button: UIButton = UIButton()
        let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        button.backgroundColor = backgroundColor
        button.setTitle("●", for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    var logBtn: UIButton = {
        let button: UIButton = UIButton()
        let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        button.backgroundColor = backgroundColor
        button.setTitle("log", for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    

    
    // video vitrate label
//    var videoBitrateLabel:UILabel = {
//        let label:UILabel = UILabel()
//        label.textColor = UIColor.white
//        return label
//    }()


    // camera choose.
    let cameraChooseSegment: UISegmentedControl = {
        let segment:UISegmentedControl = UISegmentedControl(items: ["Back", "Front"])
        segment.tintColor = UIColor.white
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    
    // MARK: Video Bitrate Change.
    func onSliderValueChanged(slider: UISlider) {
//        if slider == videoBitrateSlider {
//            let videoStep: Float = 10
//            let roundedValue = round(slider.value / videoStep) * videoStep
//            slider.value = roundedValue
//            // Do something else with the value
////            videoBitrateLabel.text = "video \(Int(slider.value))/kbps"
////            publishClient.videoEncoderSettings["bitrate"] = slider.value * 1000
//        }
    }
    
    // MARK: Pulish Video
    @objc func onStartButtonClicked(sender: UIButton) {
        if (sender.isSelected) {
            UIApplication.shared.isIdleTimerDisabled = false
            sender.setTitle("●", for: .normal)
            startBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            cmdLineText.isHidden = false
        } else {
            // 开始推流 启用屏幕常亮
            UIApplication.shared.isIdleTimerDisabled = true
            sender.setTitle("■", for: .normal)
            startBtn.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.6)
            cmdLineText.isHidden = true
        }
        sender.isSelected = !sender.isSelected
    }
    
    // MARK: Pulish Video
    @objc func onLogBtnClicked(sender: UIButton) {
        if (sender.isSelected) {
            self.logString = "sdfsdfsdfsd"
            logBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            sender.setTitle("log", for: .normal)
            logView.isHidden = true
            
        } else {
            self.logString  = "vvvvvv"
            sender.setTitle("×", for: .normal)
            logBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            logView.isHidden = false
        }
        sender.isSelected = !sender.isSelected
        
    }
    
    // MARK: Camera Choose
    @objc func onCameraChanged(segment: UISegmentedControl) {
//        switch segment.selectedSegmentIndex {
////        case 0:
//////            publishClient.devicePosition = .Back
////
////        case 1:
//////            publishClient.devicePosition = .Front
//        default:
//            break
//        }
    }
    
    func initAppInfo() {
        let documentDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        appInfoFile = documentDir[0] + "/info.plist"
        
        if !FileManager.default.fileExists(atPath: appInfoFile) {
            FileManager.default.createFile(atPath: appInfoFile, contents: nil, attributes: nil)
        }
    }
    
    private func uiInit() {
        // view.addSubview(background)
//        view.layer.addSublayer(backgroundLayer)
//        view.addSubview(rtmpUrlText)
//        view.addSubview(logButton)

//        view.addSubview(publishButton)
        view.addSubview(cameraChooseSegment)
////        view.addSubview(videoBitrateLabel)
////        view.addSubview(videoBitrateSlider)
//        view.addSubview(copyRight)
    }
    
    private func initSubview() {
        backgroundLayer.frame = view.bounds
        backgroundLayer.colors = [UIColor.purple.cgColor, UIColor.red.cgColor]
        backgroundLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        backgroundLayer.endPoint = CGPoint(x: 0.5, y: 1)
        backgroundLayer.locations = [0.65, 1]
        
        
        // cmd line input textview
        cmdLineText.frame = CGRect(x: view.frame.width * 0.1 , y: view.frame.height/2 - 100 - 40, width: view.frame.width * (1 - 0.1*2), height: 40)
        cmdLineText.textColor = UIColor.white
        cmdLineText.clearButtonMode = .whileEditing
        cmdLineText.textAlignment = .center
        
        
        // view segment
        cameraChooseSegment.frame = CGRect(x: view.bounds.width - 170 , y: 50, width: 133, height: 30)
        cameraChooseSegment.addTarget(self, action: #selector(ViewController.onCameraChanged(segment:)), for: .valueChanged)
        
//        // video Bitrate Label
//        videoBitrateLabel.text = "video \(Int(videoBitrateSlider.value))/kbps"
//        videoBitrateLabel.frame = CGRect(x: view.frame.width - 150 - 60, y: view.frame.height - 50 * 2, width: 160, height: 44)
//
        // video Bitrate Slider
//        videoBitrateSlider.frame = CGRect(x: 20, y: view.frame.height - 60 - 15, width: view.frame.width - 50 - 60, height: 40)
//        videoBitrateSlider.addTarget(self, action: #selector(ViewController.onSliderValueChanged(_:)), forControlEvents: .ValueChanged)
//        videoBitrateSlider.value = Float(300)
//
        // start btn
        startBtn.frame = CGRect(x: view.bounds.width - 50 - 20, y: view.bounds.height - 60 - 20, width: 50, height: 50)
        startBtn.layer.cornerRadius = 25.0
        startBtn.addTarget(self, action: #selector(ViewController.onStartButtonClicked(sender:)), for: .touchUpInside)
        
        // MARK: log view
        logView.frame = CGRect(x: view.frame.width * 0.01, y: 0, width: view.frame.width * (1 - 0.01*2), height: view.frame.height - 150)
        logView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        logView.layer.cornerRadius = 6
        
        // log show/hide btn
        logBtn.frame = CGRect(x: view.bounds.width - 50 - 20, y: view.bounds.height  - 140, width: 50, height: 50)
        logBtn.layer.cornerRadius = 25.0
        logBtn.addTarget(self, action: #selector(ViewController.onLogBtnClicked(sender:)), for: .touchUpInside)
        
        // copyright info.
        copyRight.frame = CGRect(x: view.frame.width/2 - 75 , y: view.bounds.height - 30, width: 150, height: 15)
        copyRight.textColor = UIColor.white
        copyRight.font = UIFont(name: "Arial", size: 10)
        
        
        view.layer.addSublayer(backgroundLayer)
        view.addSubview(cmdLineText)
        view.addSubview(logBtn)
        view.addSubview(logView)
        
        logView.isHidden = true
        
        view.addSubview(startBtn)
        view.addSubview(cameraChooseSegment)
        //        view.addSubview(videoBitrateLabel)
        //        view.addSubview(videoBitrateSlider)
        view.addSubview(copyRight)
    }
    
    private func Init() {
        copyRight.text = "©2016-2018 ChowQ"
        cmdLineText.text = "iperf3 -u "
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initAppInfo()
        self.Init()
        self.initSubview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        // 相机预览的图像在旋转屏幕的时候，必须在这个函数中重新绘制，否则会出现app界面空间布局错位的情况。
        self.initSubview()
    }
}

class CustomField: UITextField {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.green.cgColor)
        context!.fill(CGRect(x: 0, y: self.frame.height - 0.5, width: self.frame.width - 0.5, height: 0.5 ))
    }
}
