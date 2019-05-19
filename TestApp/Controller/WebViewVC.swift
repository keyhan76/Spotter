//
//  WebViewVC.swift
//  TestApp
//
//  Created by Keyhan on 5/19/19.
//  Copyright © 2019 Keyhan. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {

    // MARK: - Private Variables
    private var webView: WKWebView!
    
    // MARK: - Public Variables
    public var url: String?
    
    // MARK: - View Did Load
    override func loadView() {
        super.loadView()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        view = webView
    }
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlStr = url else {
            return
        }
        
        navigationItem.title = urlStr
        
        guard let url = URL(string: urlStr) else { return }
        
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // set back navigation bar border
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    // MARK: - View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Remove navigation bar border
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

// MARK: - WKNavigation Delegate
extension WebViewVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.startActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        // Error happend
        self.stopActivityIndicator()
    }
}
