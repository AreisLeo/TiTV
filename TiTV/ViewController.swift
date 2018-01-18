//
//  ViewController.swift
//  TiTV
//
//  Created by Ti大叔 on 2018/1/12.
//  Copyright © 2018年 Ti大叔. All rights reserved.
//

import UIKit
import AVKit
//import MediaPlayer
class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var btnVip: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //添加代理委托
        textField.delegate = self
        webview.delegate = self
        webview.allowsInlineMediaPlayback = true
        
        
        btnVip.addTarget(self, action:#selector(btnVipTapped), for:.touchUpInside)


//        NotificationCenter.default.addObserver(self, selector:  #selector(notificationAction), name: NSNotification.Name.UIWindowDidBecomeHidden, object: nil);

    }
    @objc func btnVipTapped(){
        
        var aUrl = "http://www.hifiwu.com/index.php?s=%@"
        
        
        // let toSearchword = CFURLCreateStringByAddingPercentEscapes(nil, searchword, "!*'();:@&=+$,/?%#[]", nil, CFStringBuiltInEncodings.UTF8.rawValue)
        
        /// encodeURI编码,不会对特殊符号编码
        
        if ((webview.request?.url?.absoluteString.count) != nil)
        {
            let curUrl = webview.request?.url?.absoluteString
            //
            aUrl = String(format:aUrl,curUrl!)
        }
        else
        {
            aUrl = "http://www.hifiwu.com/index.php"
        }
        
//        print(aUrl as Any)
        loadUrl(url: aUrl,web: webview);
    }
    @IBAction func goback(_ sender: UIButton) {
        webview.goBack()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //加载请求的方法
    func loadUrl(url: String, web: UIWebView) {
        
        //载入输入的请求
        let request = URLRequest(url: URL(string: url)!)
        webview.loadRequest(request)

        
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        loadUrl(url:"http://" + textField.text!, web: webview)
        //解除textField的第一响应者的注册资格，键盘消失；若没有这一步，键盘会一直留在屏幕内
        textField.resignFirstResponder()
        return true
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if (request.url?.absoluteString.contains("about:blank"))! {
            return false
        }

//        if ((request.url?.scheme) != nil) {
//            print(request.url?.scheme);//在这里可以获得事件
//        }

        if (request.url?.absoluteString.contains("share"))! {
            let data = NSData.init(contentsOf: URL.init(string: (request.url?.absoluteString)!)!)
            print(NSString.init(data: data! as Data, encoding: 0))
        }

        let canReturn = request.url?.absoluteString .contains("http://f.qcwzx.net.cn")
        print(request.url?.absoluteString)
//        print(request.httpBody)
//        print(request.allHTTPHeaderFields)
//        print(request.httpShouldUsePipelining)
//        print(request.networkServiceType)
        return !canReturn!
    }

    @objc private func notificationAction(noti: Notification) {
        /// 获取键盘的位置/高度/时间间隔...
//        for object in noti.object.map({ (object) -> Array<Any> in
//            return [object]
//        })! {
//            print((object as AnyObject).classForCoder)
//        }
//        print(noti.object)
//        print(self.view.subviews)
//        for view in self.view.subviews {
//            print(view.classForCoder)
//        }
        
        let keyWindow = UIApplication.shared.windows
//        print(keyWindow)
//        print(keyWindow)
        for keyWindowView in  keyWindow {
            if keyWindowView .isKind(of: UIWindow.classForCoder()){
                let subViews = keyWindowView.rootViewController?.view.subviews
                viewClass(viewClass: keyWindowView.classForCoder)
                if (subViews != nil) {
                    for subSubView in subViews! {
                        if subSubView .isKind(of: NSClassFromString("AVPlayerView")!) {

                            let playerView = subSubView
                            let contentView = playerView.value(forKey: "_contentView") as! UIView
//                            viewClass(viewClass: contentView.classForCoder)




                            let delegate = contentView.value(forKey: "_delegate") as! NSObject

                            let playerVC = delegate.value(forKey: "_playerViewController") as! AVPlayerViewController
//                            let player = playerVC.value(forKey: "_player") as! AVPlayer
//                            print(playerVC)
//Builtin
                        }
                    }
                }
            }
        }


//        AVAudioSession
//AVSystemController_ActiveAudioRouteDidChangeNotification
//

//        for view in webview.subviews {
//            if view .isKind(of: NSClassFromString("_UIWebViewScrollView")!) {
//                for subView in view.subviews {
//                    if subView .isKind(of: NSClassFromString("UIWebBrowserView")!) {
//                        print(subView.subviews)
//                        print(subView.layer.sublayers)
//                    }
//                }
//            }
//        }
    }

    func viewClass (viewClass :AnyClass) {
        var outCount:UInt32 = 0
        let ivars = class_copyIvarList(viewClass, &outCount)
        for i in 0..<outCount {
            let ivar = ivars?[Int(i)];
            let key = NSString.init(utf8String:ivar_getName(ivar))
            print(key)
        }
        free(ivars);
    }
}

