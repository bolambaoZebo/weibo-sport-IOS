//
//  UIViewController+Extension.swift
//  WeiboSports
//
//  Created by 96group on 4/18/22.
//

import Foundation
import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .gray)
        
        let titleLabel: UILabel = {
            let label = ZeeUILabel(withInsets: 8, 8, 8, 8)
            label.textColor = .black
            label.text = NSLocalizedString("loading_txt", comment: "nav home title")
            label.font = .systemFont(ofSize: 18, weight: .ultraLight)
            label.adjustsFontSizeToFitWidth = true
            label.clipsToBounds = true
            label.numberOfLines = 2
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        

        titleLabel.center = aView!.center
        aView?.addSubview(titleLabel)
        
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
}

