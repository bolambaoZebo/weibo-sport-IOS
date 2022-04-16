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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
        let htmldocs = HTMLDocument(string: newdata.description)
        let elements = htmldocs.querySelectorAll("p")
        
        images.forEach { img in
            print(img)
        }
        elements.forEach { item in
            print(item.textContent)

        }
        
    }
}
