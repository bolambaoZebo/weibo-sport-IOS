//
//  VideoViewController.swift
//  WeiboSports
//
//  Created by 96group on 11/20/21.
//

import UIKit
import WebKit

class VideoViewController: BaseViewController {
    
    // MARK: - Properties
    
    var video: SoccerVideo
    
    var webView: WKWebView!
    
    // MARK: - Initializer
    
    init(_ video: SoccerVideo){
        self.video = video
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setVideoData(video)
        setVideoConstraint()
        
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200), configuration: webConfiguration)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    func setVideoData(_ data: SoccerVideo) {
        let videoURL = URL(string: data.video!)
        let videoRequest = URLRequest(url: videoURL!)
        webView.load(videoRequest)
    }
    
    func setVideoConstraint(){
    }
    
}

extension VideoViewController: WKUIDelegate, WKNavigationDelegate {
     
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finish Load")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start to load")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }

}
