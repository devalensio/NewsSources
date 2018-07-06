//
//  WebView.swift
//  News
//
//  Created by Devdots on 06/07/18.
//  Copyright © 2018 Devdots. All rights reserved.
//

import UIKit

class WebView: UIViewController {
    
    var url : String?
    
    @IBOutlet weak var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newUrl = url!.replacingOccurrences(of: "http", with: "https")
        
        let data = URL(string: newUrl)
        
        webview.loadRequest(URLRequest(url: data!))
        
    }
    
}
