//
//  ArticleViewController.swift
//  NewsNewsNews
//
//  Created by The App Experts on 27/09/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit
import WebKit
import ProgressHUD

class ArticleViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var articletitleLAbel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    var source:Article?
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProgressHUD.colorAnimation = .red
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.show()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProgressHUD.dismiss()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        displayWebpage()
    }
    
    fileprivate func displayWebpage() {
        guard let url = self.source?.url else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
