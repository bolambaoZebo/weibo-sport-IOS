//
//  SoccerNewsCell.swift
//  WeiboSports
//
//  Created by 96group on 10/30/21.
//

import UIKit



class SoccerNewsCell: UITableViewCell {

    static let identifier = "homeCell"
    
    var buttomStackView = UIStackView()
    
    let singleTap = UITapGestureRecognizer(target: self, action: "")
    private let soccerImage: UIImageView = {
       let soccerImage = UIImageView()
        soccerImage.contentMode = .scaleAspectFill
        soccerImage.clipsToBounds = true
//        soccerImage.layer.cornerRadius = 5
        return soccerImage
    }()
    //        let item = news[indexPath.row]
    //        let detailVC = NewsViewController(item)
    //        navigationController?.present(detailVC, animated: true)
    
    private let titleLabel: UILabel = {
        let label = ZeeUILabel(withInsets: 8, 8, 8, 8)
//        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = ZeeUILabel(withInsets: 2, 8, 8, 2)
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 12
        label.clipsToBounds = true
//        label.backgroundColor = .white
        return label
    }()
    
    let bookmarkButton: UIButton = {
        let btn = UIButton()
        return btn
    }()

    let likeButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    let commentButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    private let stackView: UIStackView = {
        //Stack View
//        .init(arrangedSubviews: [bookmarkButton, likeButton,commentButton])
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.spacing = 12

        return stackView
    }()
    
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(soccerImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
//        contentView.backgroundColor = .red
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setImageConstraint()
        setTitleLabel()
        setDescriptionLabel()
        setButtomStackView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        soccerImage.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func setSoccerNewCell(news: NewData) {
        titleLabel.text = news.title
        descriptionLabel.text = news.date//news.description.htmlAttributedString()
        soccerImage.load(url: URL(string: news.imageUrl)!)
    }
    
    func setImageConstraint() {
        soccerImage.translatesAutoresizingMaskIntoConstraints = false
        soccerImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        soccerImage.topAnchor.constraint(equalTo: topAnchor,constant: 20).isActive = true
        soccerImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        soccerImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        soccerImage.heightAnchor.constraint(equalToConstant: contentView.frame.size.height - (titleLabel.frame.size.height + descriptionLabel.frame.size.height + stackView.frame.size.height)).isActive = true
        soccerImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true//16/9).isActive = true
    }
    
    func setTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: soccerImage.bottomAnchor, constant: 0).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: soccerImage.widthAnchor).isActive = true
    }
    
    func setDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
    }
    
    func setButtomStackView(){
 
        bookmarkButton.setImage(UIImage(systemName: "bookmark.circle"), for: .normal)
        likeButton.setImage(UIImage(systemName: "bookmark.circle"), for: .normal)
        commentButton.setImage(UIImage(systemName: "bookmark.circle"), for: .normal)
        
        stackView.addArrangedSubview(bookmarkButton)
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(commentButton)
        self.contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func convertDateFormatter(date: String) -> String {
        let dtFormatter = ISO8601DateFormatter()
        if let dt = dtFormatter.date(from: date) {
            return "\(dt.to(format: "EEEE, MMM d, yyyy"))"
        }else {
            return ""
        }
        
    }
    
//    (format: "EEEE, MMM d, yyyy", timeZone: (TimeZone(abbreviation: "UTC") ?? TimeZone.current))
}



