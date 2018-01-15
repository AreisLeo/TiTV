//
//  ViewController.swift
//  TiTV
//
//  Created by Ti大叔 on 2018/1/12.
//  Copyright © 2018年 Ti大叔. All rights reserved.
//

import UIKit

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
        
        
        
        btnVip.addTarget(self, action:#selector(btnVipTapped), for:.touchUpInside)
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
        
        
        print(aUrl as Any)
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
        let canReturn = request.url?.absoluteString .contains("http://f.qcwzx.net.cn")
        print(request.url?.absoluteString)
        return !canReturn!
    }
}

