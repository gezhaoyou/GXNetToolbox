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
    
    // iperf commind
    let cmdLineText = CustomField()
    let copyRight = UITextField()
    let logView = UITextView()
    let backgroundLayer = CAGradientLayer()
    
    var logString: String = "" {
        didSet {
            DispatchQueue.main.async(execute: {
                self.logView.text = self.logString
            })
        }
    }
    
    // start button
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
 
    // MARK:
    @objc func onStartButtonClicked(sender: UIButton) {
        if (sender.isSelected) {
            UIApplication.shared.isIdleTimerDisabled = false
            sender.setTitle("●", for: .normal)
            startBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            cmdLineText.isHidden = false
        } else {
            UIApplication.shared.isIdleTimerDisabled = true
            sender.setTitle("■", for: .normal)
            startBtn.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.6)
            cmdLineText.isHidden = true
        }
        sender.isSelected = !sender.isSelected
    }
    
    // MARK:
    @objc func onLogBtnClicked(sender: UIButton) {
        if (sender.isSelected) {
            self.logString = ""
            logBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            sender.setTitle("log", for: .normal)
            logView.isHidden = true
            
        } else {
            self.logString  = ""
            sender.setTitle("×", for: .normal)
            logBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            logView.isHidden = false
        }
        sender.isSelected = !sender.isSelected
    }
        
 
    func initAppInfo() {
        let documentDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        appInfoFile = documentDir[0] + "/info.plist"
        
        if !FileManager.default.fileExists(atPath: appInfoFile) {
            FileManager.default.createFile(atPath: appInfoFile, contents: nil, attributes: nil)
        }
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
        cmdLineText.text = "iperf3 -u "
        
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
        copyRight.frame = CGRect(x: view.frame.width/2 - 55,
                                 y: view.bounds.height - 30,
                                 width: 110,
                                 height: 15)
        copyRight.textColor = UIColor.white
        copyRight.font = UIFont(name: "Arial", size: 10)
        copyRight.text = "©2016-2018 gezhaoyou"
       
        
        view.layer.addSublayer(backgroundLayer)
        view.addSubview(cmdLineText)
        view.addSubview(logBtn)
        view.addSubview(logView)
        
        logView.isHidden = true
        
        view.addSubview(startBtn)
        view.addSubview(copyRight)
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initAppInfo()
        self.initSubview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        self.initSubview()
    }
}

class CustomField: UITextField {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.green.cgColor)
        context!.fill(CGRect(x: 0,
                             y: self.frame.height - 0.5,
                         width: self.frame.width - 0.5,
                        height: 0.5 ))
    }
}
