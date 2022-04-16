//
//  HighLightsViewController.swift
//  WeiboSports
//
//  Created by 96group on 10/28/21.
//
import UIKit

class HighLightsViewController: UIViewController {
    
    private let apiCaller = APICaller()
    
    private let highlightsTableView: UITableView = {
        let tv = UITableView()//(frame: .zero, style: .grouped)
        tv.separatorColor = UIColor.clear
        tv.register(SoccerVideoCell.self, forCellReuseIdentifier: SoccerVideoCell.identifier)
        return tv
    }()
    
    private var video: [SoccerVideo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        highlightsTableView.dataSource = self
        highlightsTableView.delegate = self
        view.addSubview(highlightsTableView)
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        highlightsTableView.frame = view.bounds
        
        apiCaller.fetchData(pagination: false, completion: { [weak self] results in
            switch results {
            case .success(let data):
                self?.video.append(contentsOf: data)
                print(data)
                DispatchQueue.main.async {
                    self?.highlightsTableView.reloadData()
                }
            case .failure(_):
                break
            }
        })
    }
    
    private func setupView() {
        configureNavigationBar(largeTitleColor: .white, backgoundColor: hexStringToUIColor(hex: "#6e25bc"), tintColor: .white, title: "Weibo Sports", preferredLargeTitle: false)
        navigationController?.navigationBar.tintColor = .systemGray
        navigationController?.navigationBar.backgroundColor = hexStringToUIColor(hex: "#f0f5f4")
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)!]
        self.navigationController?.navigationBar.topItem?.title = "Soccer News"
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
}

// MARK: - UITableview Delegates

extension HighLightsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = highlightsTableView.dequeueReusableCell(withIdentifier: SoccerVideoCell.identifier, for: indexPath) as? SoccerVideoCell else {
            return UITableViewCell()
        }
        let newCell = video[indexPath.row]
        
        let backgroundView = UIView()
        cell.selectedBackgroundView = backgroundView
        cell.clipsToBounds = true
        cell.setSoccerVideoCell(video: newCell)
        return cell
    }
    
    private func createSpinerFoorter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 12))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (highlightsTableView.contentSize.height-100-scrollView.frame.size.height) {
            
            guard !apiCaller.isPaginating else {
                return
            }
            self.highlightsTableView.tableFooterView = createSpinerFoorter()
            
            apiCaller.fetchData(pagination: true) { [weak self] result in
                DispatchQueue.main.async {
                    self?.highlightsTableView.tableFooterView = nil
                }
                switch result {
                case .success(let moreData):
                    self?.video.append(contentsOf: moreData)
                    DispatchQueue.main.async {
                        self?.highlightsTableView.reloadData()
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = video[indexPath.row]
        let videoVC = VideoViewController(item)
        navigationController?.present(videoVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return video.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}
