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
        let soccer = SoccerViewController()
        let horse = HorseViewController()
        let stats = StatsViewController()
        let LiveGame = BookMarksViewController()
        
        let homeImage = UIImage(systemName: "house.fill")
        let soccerImage = UIImage(named: "soccer24")
        let horseImage = UIImage(named: "horse24")
        let statsImage = UIImage(named: "scoreboard24")
        let liveGameImage = UIImage(named: "live24")
        
        viewControllers = [
            createNavController(viewController: home, tabImage: homeImage,  NSLocalizedString("home_tab_txt", comment: "nav home title")),
            createNavController(viewController: soccer, tabImage: soccerImage, NSLocalizedString("soccer_txt", comment: "nav soccer title")),
            createNavController(viewController: horse, tabImage: horseImage, NSLocalizedString("horse_txt", comment: "nav horse title")),
            createNavController(viewController: stats, tabImage: statsImage, NSLocalizedString("live_score_txt", comment: "nav live score title")),
            createNavController(viewController: LiveGame, tabImage: liveGameImage, NSLocalizedString("live_stream_txt", comment: "nav live stream title"))
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
