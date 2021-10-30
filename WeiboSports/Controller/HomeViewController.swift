//
//  HomeViewController.swift
//  WeiboSports
//
//  Created by 96group on 10/28/21.
//

import UIKit

class HomeViewController: UIViewController ,UINavigationControllerDelegate {
    
    private let homeTableView: UITableView = {
        let table = UITableView()
        table.register(SoccerNewsCell.self, forCellReuseIdentifier: SoccerNewsCell.identifier)
        return table
    }()
    
    private var news: [EnglishData] = []
    private var isActive: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        setupView()
        
        fetch()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTableView.frame = view.bounds
    }
    
    
    @objc fileprivate func handleLogin() {
        print("Show login and sign up pages")
        let navController = UINavigationController(rootViewController: StatsViewController())
        present(navController, animated: true)
    }
    

}
extension HomeViewController {
    func fetch() {
        URLSession.shared.request(
            url: BaseUrl.soccerNewsUrl,
            expecting: News.self)
        { [weak self] result in
            switch result {
            case .success(let news):
                DispatchQueue.main.async {
                    self?.news = news.en
                    self?.isActive = news.isActive
                    self?.homeTableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension HomeViewController {
    private func setupView() {
        configureNavigationBar(largeTitleColor: .white, backgoundColor: hexStringToUIColor(hex: "#6e25bc"), tintColor: .white, title: "Weibo Sports", preferredLargeTitle: false)
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 32)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.rightBarButtonItems = [
            .init(image: UIImage(systemName: "gear"), style: .plain, target: self, action: nil)
        ]
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SoccerNewsCell.identifier,
                                                                  for: indexPath) as? SoccerNewsCell else {
                                                                    return UITableViewCell()
        }
        let newsCell = news[indexPath.row]
        let backgroundView = UIView()
        cell.selectedBackgroundView = backgroundView
        cell.setSoccerNewCell(news: newsCell)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
    
}


