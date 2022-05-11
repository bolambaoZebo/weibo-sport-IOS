//
//  StatsViewController.swift
//  WeiboSports
//
//  Created by 96group on 10/28/21.
//

import UIKit
import WebKit

//https://www.nowgoal.pro

class StatsViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
//    private var news: WebVData?
    private var isActive: Bool = false
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        fetch()
    }
    
    private func setupView() {
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: hexStringToUIColor(hex: "#6e25bc"), tintColor: .white, title: "Weibo Sports", preferredLargeTitle: false)
        navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "#f0f5f4")
        navigationController?.navigationBar.tintColor = .systemGray
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)!]
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("live_score_txt", comment: "nav live score title")
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }

}
    //MARK: - API CALL

extension StatsViewController {
    
    func loadWebView(url: String?){
        self.removeSpinner()
//        let url = URL(string: "https://www.scorebat.com/embed/livescore/")!
        guard let data = url else{
            return
        }
        let url = URL(string: data)!
        self.webView.load(URLRequest(url: url))
        self.webView.allowsBackForwardNavigationGestures = true
    }
    
    func loadWVErr(){
        self.removeSpinner()
        let url = URL(string: "https://www.scorebat.com/embed/livescore/")!
        self.webView.load(URLRequest(url: url))
    }
    func fetch() {
        self.showSpinner()
        URLSession.shared.request(
            url: BaseUrl.webviewLiveScore,
            expecting: WebVData.self)
        { [weak self] result in
            switch result {
            case .success(let webdata):
                DispatchQueue.main.async {
                    if(webdata.isActive){
                        self?.loadWebView(url: webdata.url)
                    }else{
                        self?.loadWVErr()
                    }
                }
            case .failure(let error):
                print(error)
                self?.loadWVErr()
            }
        }
    }
}
