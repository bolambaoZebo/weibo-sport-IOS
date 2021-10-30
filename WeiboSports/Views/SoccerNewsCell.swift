//
//  SoccerNewsCell.swift
//  WeiboSports
//
//  Created by 96group on 10/30/21.
//

import UIKit

class SoccerNewsCell: UITableViewCell {

    static let identifier = "homeCell"
    
    private let soccerImage: UIImageView = {
       let soccerImage = UIImageView()
        soccerImage.contentMode = .scaleAspectFill
        soccerImage.clipsToBounds = true
//        soccerImage.layer.cornerRadius = 5
        return soccerImage
    }()
    
    private let titleLabel: UILabel = {
        let label = ZeeUILabel(withInsets: 8, 8, 8, 8)
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = ZeeUILabel(withInsets: 8, 8, 8, 8)
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 10
        label.clipsToBounds = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(soccerImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setImageConstraint()
        setTitleLabel()
        setDescriptionLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        soccerImage.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func setSoccerNewCell(news: EnglishData) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        soccerImage.load(url: URL(string: news.imageUrl)!)
    }
    
    func setImageConstraint() {
        soccerImage.translatesAutoresizingMaskIntoConstraints = false
        soccerImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        soccerImage.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        soccerImage.heightAnchor.constraint(equalToConstant: 210).isActive = true
        soccerImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true//16/9).isActive = true
    }
    
    func setTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: soccerImage.bottomAnchor, constant: 8).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: soccerImage.widthAnchor).isActive = true
    }
    
    func setDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



