//
//  HighLightsViewController.swift
//  WeiboSports
//
//  Created by 96group on 10/28/21.
//

import UIKit

class APICaller {
    
    var isPaginating = false
    
    func fetchData(pagination: Bool=false, completion: @escaping (Result<[String], Error>) -> Void) {
        if pagination {
            isPaginating = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: {
            let original = [
                "apple",
                "apple",
                "apple",
                "apple",
                "apple","apple","apple",
                "apple",
                "apple",
                "apple","apple",
                "apple",
                "apple",
                "apple",
                "apple",
                "apple",
                "apple","apple",
                "apple",
                "apple",
                "apple",
                "apple"
            ]
            let newData = [
                "talong",
                "ni",
                "caloy"
            ]
            completion(.success(pagination ? newData : original))
            if pagination {
                self.isPaginating = false
            }
        })
        
    }
}

class HighLightsViewController: UIViewController {
    
    private let apiCaller = APICaller()
    
    private let highlightsTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "highlightsCell")
        return tv
    }()
    
    private var data = [String]()

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
                self?.data.append(contentsOf: data)
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
        self.navigationController?.navigationBar.topItem?.title = "Highlights"
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
}

extension HighLightsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = highlightsTableView.dequeueReusableCell(withIdentifier: "highlightsCell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
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
                    self?.data.append(contentsOf: moreData)
                    DispatchQueue.main.async {
                        self?.highlightsTableView.reloadData()
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    
    
}
