//
//  BaseViewController.swift
//  WeiboSports
//
//  Created by 96group on 11/20/21.
//

import UIKit

class BaseViewController: UIViewController {

    let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 42, height: 50)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = true
        return backButton
    }()
    
    @objc func backAction(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
        print("backing")
    }
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(backButton)
        
        setViewConstraint()
    }
    
    // MARK: - UI SECTION
    
    func setViewConstraint(){
        
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 8).isActive = true
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
    }

}
