//
//  StatsViewController.swift
//  WeiboSports
//
//  Created by 96group on 10/28/21.
//

import UIKit
import WebKit

class StatsViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let url = URL(string: "https://www.scorebat.com/embed/livescore/")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func setupView() {
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: hexStringToUIColor(hex: "#6e25bc"), tintColor: .white, title: "Weibo Sports", preferredLargeTitle: false)
        navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "#f0f5f4")
        navigationController?.navigationBar.tintColor = .systemGray
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)!]
        self.navigationController?.navigationBar.topItem?.title = "Horse News"
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }

}
