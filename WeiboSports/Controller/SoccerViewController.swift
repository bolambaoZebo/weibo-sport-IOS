//
//  SoccerViewController.swift
//  WeiboSports
//
//  Created by 96group on 4/16/22.
//

import UIKit

class SoccerViewController: UIViewController ,UINavigationControllerDelegate {
    
//MARK: - Uiviews
    var isLoading: Bool = false
    
    private let homeTableView: UITableView = {
        let table = UITableView()//UITableView(frame: .zero, style: .grouped)
        table.separatorColor = UIColor.clear
        table.showsVerticalScrollIndicator = false
        table.register(SoccerNewsCell.self, forCellReuseIdentifier: SoccerNewsCell.identifier)
        table.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        return table
    }()

    
// MARK: - Properties
    
    private var news: [NewData] = []
    private var isActive: Bool = false
    private var link: String?
    
// MARK: - lifecycles
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    @objc fileprivate func handleLogin() {
//        print("Show login and sign up pages")
//        let navController = UINavigationController(rootViewController: StatsViewController())
//        present(navController, animated: true)
//    }
    
    @objc fileprivate func switchLanguage() {
        print("refresh soccer // line 54")
        if(!isLoading){
            fetch()
            self.scrollToTop()
        }
    }
    
    @objc fileprivate func returnOrigin() {
        if(!isLoading){
            self.scrollToTop()
        }
    }
    
    private func scrollToTop() {
        let topRow = IndexPath(row: 0,section: 0)
                               
        if(!news.isEmpty){
            self.homeTableView.scrollToRow(at: topRow,
                                       at: .top,
                                       animated: true)
        }
    }
    
}

 // MARK: - Extension

extension SoccerViewController {
    
    func fetch() {
        
        self.showSpinner()

        switch(Locale.current.languageCode!){
            case "en":
                switchBaseUrl(baseUrl: BaseUrl.soccerNewsUrlEN)
            case "zh":
                switchBaseUrl(baseUrl: BaseUrl.soccerNewsUrlZH)
            default:
                print("none")
        }
    }
    
    func switchBaseUrl(baseUrl: URL!){
            URLSession.shared.request(
                url: baseUrl,
                expecting: News.self)
            { [weak self] result in
                switch result {
                case .success(let news):

                    DispatchQueue.main.async {
                        self?.news = news.data
                        self?.isActive = news.isActive
                        self?.removeSpinner()
                        self?.homeTableView.reloadData()
                        
                        if let link = news.link {
                            self?.link = link
                        }
                    }

                case .failure(let error):
                    print(error)
                }
            }
    }
    
}

// MARK: - Navigation bar configuration

extension SoccerViewController {
    private func setupView() {
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: hexStringToUIColor(hex: "#6e25bc"), tintColor: .white, title: NSLocalizedString("soccer_txt", comment: "nav soccer title"), preferredLargeTitle: false)
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 32)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        let refresh = UIButton.init(type: .custom)
        refresh.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        refresh.addTarget(self, action: #selector(switchLanguage), for: .touchUpInside)
        
        let goUp = UIButton.init(type: .custom)
        goUp.setImage(UIImage(systemName: "arrow.up.square"), for: .normal)
        goUp.addTarget(self, action: #selector(returnOrigin), for: .touchUpInside)
        
        let stackview = UIStackView.init(arrangedSubviews: [goUp,refresh])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 18

        let rightButtons = UIBarButtonItem(customView: stackview)
        
//        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.rightBarButtonItems = [rightButtons]
        

//        .init(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(switchLanguage))
//    navigationItem.rightBarButtonItems = [rightBarButton1,rightBarButton2]
        
    }
    
}

// MARK: - Uitableview Extension

extension SoccerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SoccerNewsCell.identifier,
                                                       for: indexPath) as? SoccerNewsCell else {
            return UITableViewCell()
        }
        let newsCell = news[indexPath.row]
        let backgroundView = UIView()
        cell.selectedBackgroundView = backgroundView
        cell.clipsToBounds = true
        cell.setSoccerNewCell(news: newsCell)
        return cell
    }
    
//    private func createSpinnerHeader() -> UIView {
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
//        let imageSlider = UIImageView()
//        imageSlider.contentMode = .scaleAspectFill
//        headerView.addSubview(imageSlider)
//        imageSlider.load(url: URL(string: "https://96group.s3.ap-southeast-1.amazonaws.com/a_horse.png")!)
//
//        return headerView
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = news[indexPath.row]
//        let detailVC = NewsViewController(item)
//        navigationController?.present(detailVC, animated: true)
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
//        return header
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = news[indexPath.row]
        
        didTapCell(data: data)
        
    }
    
    func didTapCell(data: NewData) {
        let reusableVc = ReusableViewController()
        reusableVc.data = data
        reusableVc.showAds = isActive
        reusableVc.link = self.link
        navigationController?.present(reusableVc, animated: true)
        
    }
    
}




