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
    var temptext: String = ""
    private lazy var imageCollection: [UIImageView] = []
    
    private let headerImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let content: UILabel = {
       let label = ZeeUILabel(withInsets: 0, 0, 8, 8)
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.textAlignment = .justified
        label.numberOfLines = 2000
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        guard let newdata = data else{
            return
        }
        let htmldocs = HTMLDocument(string: newdata.description)
        let elements = htmldocs.querySelectorAll("p")
        
        headerImage.load(url: URL(string: newdata.imageUrl)!)
        
        elements.forEach { item in
//            print(item.textContent)

            temptext += "\n\n\(item.textContent)"
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScrollView()
    }
    
    private func setupScrollView() {
        
        let attribute = NSAttributedString(string:temptext).withLineSpacing(8)
        content.attributedText = attribute
        
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
        
        configureContainerView()
    }
    private func configureContainerView() {
        scrollStackViewContainer.addArrangedSubview(headerImage)
        scrollStackViewContainer.addArrangedSubview(content)
    }
    
    private func setupDynamicImageFromUrl(){
        
//        let myWidth = 40
//        let myHeight = 40
        
        guard let newdata = data else{
            return
        }
        let docs = HTMLDocument(string: newdata.description)
        let images: [String] = docs.querySelectorAll("img").compactMap { element in
            guard let src = element.attributes["src"] as? String else {
                return nil
            }
            return src
        }
        
        images.forEach { img in
            
            print(img)
//            let imageView: UIImageView = UIImageView()
//            imageView.load(url: URL(string: img)!)
//            imageView.frame = CGRect(x: 10, y: myHeight , width: myWidth, height: myHeight)
//
//            // add to parent view
//            scrollStackViewContainer.addArrangedSubview(imageView)
        }
    }

}
