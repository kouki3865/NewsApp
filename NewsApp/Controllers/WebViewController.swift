//
//  WebViewController.swift
//  NewsApp
//
//  Created by koki on 2022/01/30.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 50)
        view.addSubview(webView)
        
        guard let urlstring = UserDefaults.standard.object(forKey: "url") else {return}
        guard  let url = URL(string: urlstring as! String) else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    
}

extension WebViewController:WKUIDelegate{
    
}
