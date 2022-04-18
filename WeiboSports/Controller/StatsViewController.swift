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
    
    private var news: [NewData] = []
    private var isActive: Bool = false
    
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
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("live_score_txt", comment: "nav live score title")
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }

}
    //MARK: - API CALL

extension StatsViewController {
    func fetch() {
        self.showSpinner()
        URLSession.shared.request(
            url: BaseUrl.allNewsUrl,
            expecting: News.self)
        { [weak self] result in
            switch result {
            case .success(let news):

                DispatchQueue.main.async {
                    self?.news = news.data
                    self?.isActive = news.isActive
                    self?.removeSpinner()
//                    self?.homeTableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
