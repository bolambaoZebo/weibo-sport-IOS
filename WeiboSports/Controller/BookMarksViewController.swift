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

        setupView()
        // Do any additional setup after loading the view.
    }
    private func setupView() {
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: hexStringToUIColor(hex: "#6e25bc"), tintColor: .white, title: "Weibo Sports", preferredLargeTitle: false)
        navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "#f0f5f4")
        navigationController?.navigationBar.tintColor = .systemGray
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)!]
        self.navigationController?.navigationBar.topItem?.title = "Bookmarks"
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
}
