//
//  BookMarksViewController.swift
//  WeiboSports
//
//  Created by 96group on 10/28/21.
//

import UIKit

class BookMarksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupView()
        // Do any additional setup after loading the view.
    }
    
    @objc fileprivate func filterBookmark(){
        print("filter bookmark")
    }
    
    @objc fileprivate func searchBookmark(){
        print("search bookmar")
    }
    
    private func setupView() {
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: hexStringToUIColor(hex: "#6e25bc"), tintColor: .white, title: "Weibo Sports", preferredLargeTitle: false)
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)!]
        
        self.navigationController?.navigationBar.topItem?.title = "Bookmarks"
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
//        navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "#f0f5f4")
        
//        navigationController?.navigationBar.tintColor = .systemGray
        
        let btnSearch = UIButton.init(type: .custom)
        btnSearch.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .normal)
        btnSearch.addTarget(self, action: #selector(searchBookmark), for: .touchUpInside)
        
        let btnEdit = UIButton.init(type: .custom)
        btnEdit.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        btnEdit.addTarget(self, action: #selector(filterBookmark), for: .touchUpInside)
        
        let stackview = UIStackView.init(arrangedSubviews: [btnSearch,btnEdit])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 18
        
        let rightBarButton = UIBarButtonItem(customView: stackview)
        self.navigationItem.rightBarButtonItem = rightBarButton
//        navigationItem.rightBarButtonItems = [
//            .init(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(filterBookmark)),
//            .init(image: UIImage(systemName: "magnifyingglass.circle"), style: .plain, target: self, action: #selector(searchBookmark))
//        ]
    }
}
