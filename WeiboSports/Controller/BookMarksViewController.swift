//
//  BookMarksViewController.swift
//  WeiboSports
//
//  Created by 96group on 10/28/21.
//

import UIKit
import WebKit

//<iframe src="https://www.scorebat.com/embed/" frameborder="0" width="600" height="760" allowfullscreen allow='autoplay; fullscreen' style="width:600px;height:760px;overflow:hidden;display:block;" class="_scorebatEmbeddedPlayer_"></iframe><script>(function(d, s, id) { var js, fjs = d.getElementsByTagName(s)[0]; if (d.getElementById(id)) return; js = d.createElement(s); js.id = id; js.src = 'https://www.scorebat.com/embed/embed.js?v=arrv'; fjs.parentNode.insertBefore(js, fjs); }(document, 'script', 'scorebat-jssdk'));</script>

class BookMarksViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupView()
        
        let htmlToLoad = "<iframe src=\"https://www.scorebat.com/embed/\" frameborder=\"0\" width=\"600\" height=\"760\" allowfullscreen allow='autoplay; fullscreen' style=\"width:600px;height:760px;overflow:hidden;display:block;\" class=\"_scorebatEmbeddedPlayer_\"></iframe><script>(function(d, s, id) { var js, fjs = d.getElementsByTagName(s)[0]; if (d.getElementById(id)) return; js = d.createElement(s); js.id = id; js.src = 'https://www.scorebat.com/embed/embed.js?v=arrv'; fjs.parentNode.insertBefore(js, fjs); }(document, 'script', 'scorebat-jssdk'));</script>"
        
        webView.loadHTMLString(htmlToLoad, baseURL: nil)
//        let url = URL(string: "https://weibosports.com/football-live/")!
//        webView.load(URLRequest(url: url))
//        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc fileprivate func filterBookmark(){
        print("filter bookmark")
    }
    
    @objc fileprivate func searchBookmark(){
        print("search bookmar")
    }
    
    private func setupView() {
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: hexStringToUIColor(hex: "#6e25bc"), tintColor: .white, title: NSLocalizedString("live_stream_txt", comment: "nav live stream title"), preferredLargeTitle: false)
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)!]
        
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("live_stream_txt", comment: "nav live stream title")
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
//        navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "#f0f5f4")
        
//        navigationController?.navigationBar.tintColor = .systemGray
        
//        let btnSearch = UIButton.init(type: .custom)
//        btnSearch.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .normal)
//        btnSearch.addTarget(self, action: #selector(searchBookmark), for: .touchUpInside)
//
//        let btnEdit = UIButton.init(type: .custom)
//        btnEdit.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
//        btnEdit.addTarget(self, action: #selector(filterBookmark), for: .touchUpInside)
//
//        let stackview = UIStackView.init(arrangedSubviews: [btnSearch,btnEdit])
//        stackview.distribution = .equalSpacing
//        stackview.axis = .horizontal
//        stackview.alignment = .center
//        stackview.spacing = 18
//
//        let rightBarButton = UIBarButtonItem(customView: stackview)
//        self.navigationItem.rightBarButtonItem = rightBarButton
//        navigationItem.rightBarButtonItems = [
//            .init(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(filterBookmark)),
//            .init(image: UIImage(systemName: "magnifyingglass.circle"), style: .plain, target: self, action: #selector(searchBookmark))
//        ]
    }
}
