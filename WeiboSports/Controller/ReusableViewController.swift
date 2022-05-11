//
//  ReusableViewController.swift
//  WeiboSports
//
//  Created by 96group on 4/15/22.
//

import UIKit
import HTMLKit

class ReusableViewController: UIViewController {

    var data: NewData?
    var showAds: Bool?
    var temptext: String = ""
    var temptext2: String = ""
    var link: String?
    let array = ["ads1","ads2","ads3","ads4"]
    
    private lazy var imageCollection: [UIImageView] = []
    
    var widthView: UIView!
    
    private let headerImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let adsImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "ads1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let bodyContent: UILabel = {
       let label = ZeeUILabel(withInsets: 0, 0, 8, 8)
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .justified
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let footerContent: UILabel = {
       let label = ZeeUILabel(withInsets: 0, 0, 8, 8)
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .justified
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        widthView = self.view
        
        setupContent()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScrollView()
        activateAds()
    }
    
    private func activateAds(){
        
        if let showAds = showAds {
            if(showAds){
                adsImageView.image = UIImage(named: array.randomElement()!)
                adsImageView.addTapGestureRecognizer { [weak self] in
                    self?.gotoLink()
                }
            }else {
                adsImageView.image = UIImage(named: "icon soccer")
            }
        }
        
    }
    
    private func gotoLink(){
        guard let urlLink = self.link else {
            return
        }
        
        if let url = URL(string: urlLink) {
            UIApplication.shared.open(url)
        }
    }
    
    private func setupContent(){
        guard let newdata = data else{
            return
        }
        let htmldocs = HTMLDocument(string: newdata.description)
        let elements = htmldocs.querySelectorAll("p")
        
        headerImage.load(url: URL(string: newdata.imageUrl)!)
        
        let count = elements.count / 2
        
        for (index, text) in elements.enumerated() {
            
            if(index == 0){
                temptext += "\n\(text.textContent)"
            }
            else if(index <= count && index > 0){
                temptext += "\(text.textContent)\n\n"
            }else{
                temptext2 += "\n\(text.textContent)\n"
            }
        }
        
//        elements.forEach { item in
//            print(item.textContent)
//
//            temptext += "\n\n\(item.textContent)"
//        }
    }
    
    private func setupScrollView() {
        
        let attribute = NSAttributedString(string:temptext).withLineSpacing(6)
        let attribute2 = NSAttributedString(string:temptext2).withLineSpacing(6)
        bodyContent.attributedText = attribute
        footerContent.attributedText = attribute2
        
        let margins = view.layoutMarginsGuide
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        headerImage.heightAnchor.constraint(equalToConstant: 220).isActive = true
        adsImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        configureContainerView()
    }
    private func configureContainerView() {
        scrollStackViewContainer.addArrangedSubview(headerImage)
        scrollStackViewContainer.addArrangedSubview(bodyContent)
        scrollStackViewContainer.addArrangedSubview(adsImageView)
        scrollStackViewContainer.addArrangedSubview(footerContent)
    }
    
//    private func setupDynamicImageFromUrl(){
//
//
//        guard let newdata = data else{
//            return
//        }
//        let docs = HTMLDocument(string: newdata.description)
//        let images: [String] = docs.querySelectorAll("img").compactMap { element in
//            guard let src = element.attributes["src"] as? String else {
//                return nil
//            }
//            return src
//        }
//    }

}
