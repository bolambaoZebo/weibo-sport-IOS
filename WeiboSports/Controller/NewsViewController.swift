//
//  NewsViewController.swift
//  WeiboSports
//
//  Created by 96group on 11/17/21.
//

import UIKit

class NewsViewController: BaseViewController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    var newsdata: EnglishData
    
    lazy var contextViewSize = CGSize(width: self.view.frame.width, height: containerViewHeight + diffHeight)
    
    lazy var containerViewHeight: CGFloat = DynamicLabelSize.height(text: newsdata.description, font: UIFont.systemFont(ofSize: 16), width: self.view.frame.width)
    
    lazy var diffHeight = containerViewHeight
    
    lazy var newsImage: UIImageView = {
       let soccerImage = UIImageView()
        soccerImage.contentMode = .scaleAspectFill
        soccerImage.clipsToBounds = true
//        soccerImage.layer.cornerRadius = 5
        return soccerImage
    }()
    
    lazy var newsTitleLabel: UILabel = {
        let label = ZeeUILabel(withInsets: 8, 8, 8, 8)
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.numberOfLines = 2
        return label
    }()
    
    lazy var newsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = contextViewSize
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        scrollView.frame = self.view.bounds
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.autoresizingMask = .flexibleHeight
        return scrollView
    }()
    
    // MARK: - INITIALIZER
    
    init(_ news: EnglishData){
        self.newsdata = news
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(backButton)
        setNewsData(newsdata)
        setNewsViewConstraint()
    }
    
    func setNewsData(_ data: EnglishData) {
        newsImage.load(url: URL(string: data.imageUrl)!)
        newsTitleLabel.text = data.title
        newsDescriptionLabel.text = data.description
    }
    
    // MARK: - UI SECTION
    
    func setNewsViewConstraint(){
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        scrollView.addSubview(newsImage)
        scrollView.addSubview(newsTitleLabel)
        scrollView.addSubview(newsDescriptionLabel)
        
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        newsImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true
        newsImage.heightAnchor.constraint(equalToConstant: 190).isActive = true
        newsImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        newsTitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        newsTitleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 0).isActive = true
        newsTitleLabel.widthAnchor.constraint(equalTo: newsImage.widthAnchor).isActive = true
        
        newsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        newsDescriptionLabel.setLineSpacing(lineSpacing: 2.0,lineHeightMultiple: 1.2)
        
        newsDescriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        newsDescriptionLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 0).isActive = true
        
        newsDescriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -14).isActive = true
        
    }
    
}
