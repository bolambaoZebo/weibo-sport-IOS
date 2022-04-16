//
//  HomeTableViewHeader.swift
//  WeiboSports
//
//  Created by 96group on 11/17/21.
//

import UIKit

class SubclassUIcollectionViewCell: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    //    let data = [UIColor.red,UIColor.green,UIColor.brown,UIColor.purple,UIColor.orange]
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon soccer")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    func setupCellImage(imagezName: String) {
        self.imageView.image = UIImage(named: "\(imagezName)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViewContraint()
    }
    func setupViewContraint(){
        imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height).isActive = true
    }
}

extension TableHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageNamez.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SubclassUIcollectionViewCell {
            
            cell.setupCellImage(imagezName: imageNamez[indexPath.row])
            return cell
        }
        fatalError("Unable to dequeue subclass cell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int((x/contentView.frame.width).rounded())
        
    }
    
    
}
class TableHeader: UITableViewHeaderFooterView{
    
    static let identifier = "TableHeader"
    
    let imageNamez = ["ads1","ads2","ads3","ads4"]
    //    private let imageView: UIImageView = {
    //        let imageView = UIImageView()
    //        imageView.contentMode = .scaleAspectFit
    //        imageView.image = UIImage(named: "icon soccer")
    //        imageView.translatesAutoresizingMaskIntoConstraints = false
    //        imageView.contentMode = .scaleToFill
    //        return imageView
    //    }()
    //
    //    private let label: UILabel = {
    //        let label = UILabel()
    //        label.text  = "Test Pro"
    //        label.font = .systemFont(ofSize: 22, weight: .semibold)
    //        label.textAlignment = .center
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        return label
    //    }()
    
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 4
        collectionView.isPagingEnabled = true
        return collectionView
        
        //        layout.itemSize = CGSize(width: 240, height: 100)
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = imageNamez.count
        pc.isUserInteractionEnabled = false
        //        let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        //        contentView.addSubview(pageControl)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SubclassUIcollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [pageControl])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        contentView.addSubview(bottomControlsStackView)
        //        collectionView.alwaysBounceVertical = true
        //        collectionView.backgroundColor = .blue
    }
    //        contentView.addSubview(imageView)
    //        contentView.addSubview(label)
    //        contentView.addSubview(collectionView)
    //        contentView.addSubview(collectionView)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureContents()
    }
    
    //        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    //
    //        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    //        layout.itemSize = CGSize(width: 60, height: 60)
    //        layout.scrollDirection = .horizontal
    //
    //        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    //
    
    func configureContents() {
        
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -2).isActive = true
        
        pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }

}



//        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
//        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
//        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//
//        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12).isActive = true
//        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
// Center the image vertically and place it near the leading
// edge of the view. Constrain its width and height to 50 points.
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: contentView.la),
//            imageView.heightAnchor.constraint(equalToConstant: 50),
//            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//
//            // Center the label vertically, and use it to fill the remaining
//            // space in the header view.
//            label.heightAnchor.constraint(equalToConstant: 30),
//            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
//            label.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
//            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//        ])
