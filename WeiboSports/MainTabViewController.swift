//
//  ViewController.swift
//  WeiboSports
//
//  Created by 96group on 10/28/21.
//

import UIKit

class MainTabViewController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    fileprivate func createNavController(viewController: UIViewController, tabImage: UIImage?, _ titleTabbar: String) -> UIViewController{
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = tabImage
        navController.tabBarItem.title = titleTabbar
        return navController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        self.delegate = self
        
        let home = HomeViewController()
        let highLights = HighLightsViewController()
        let stats = StatsViewController()
        let bookMarks = BookMarksViewController()
        
        let homeImage = UIImage(systemName: "house.fill")
        let highLightsImage = UIImage(systemName: "flame.fill")
        let statsImage = UIImage(systemName: "chart.bar.doc.horizontal.fill")
        let bookMarksImage = UIImage(systemName: "book.fill")
        
        viewControllers = [
            createNavController(viewController: home, tabImage: homeImage, "Home"),
            createNavController(viewController: highLights, tabImage: highLightsImage, "Highlights"),
            createNavController(viewController: stats, tabImage: statsImage, "Stats"),
            createNavController(viewController: bookMarks, tabImage: bookMarksImage, "Bookmarks")
        ]
        
    }


}

extension MainTabViewController : UINavigationControllerDelegate {}

extension MainTabViewController {
    fileprivate func setupView(){
        tabBar.tintColor = hexStringToUIColor(hex: "#6e25bc")
        tabBar.backgroundColor = hexStringToUIColor(hex: "#f0f5f4")
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
