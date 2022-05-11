//
//  SoccerNewsCell.swift
//  WeiboSports
//
//  Created by 96group on 10/30/21.
//

import UIKit



class SoccerNewsCell: UITableViewCell {

    static let identifier = "homeCell"
    
    var isSoccer: Bool = true
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
        label.font = .systemFont(ofSize: 18, weight: .semibold)
//        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = ZeeUILabel(withInsets: 2, 16, 8, 2)
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.numberOfLines = 12
        label.clipsToBounds = true
//        label.backgroundColor = .white
        return label
    }()
    
    let bookmarkButton: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    let likeButton: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let commentButton: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let btn4: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let btn5: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
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
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4))
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
        titleLabel.text = news.title.htmlDecoded
        descriptionLabel.text = convertDateFormat(inputDate: news.date)//news.description.htmlAttributedString()
        soccerImage.load(url: URL(string: news.imageUrl)!)
        
    }
    
    func setImageConstraint() {
        soccerImage.translatesAutoresizingMaskIntoConstraints = false
        soccerImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        soccerImage.topAnchor.constraint(equalTo: topAnchor,constant: 0).isActive = true
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
        descriptionLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
    }
    
    func setButtomStackView(){
        
        if(isSoccer){
            bookmarkButton.image = UIImage(named: "epl")
            likeButton.image = UIImage(named: "laliga")
            commentButton.image = UIImage(named: "seriea")
            btn4.image = UIImage(named: "bundesliga")
            btn5.image = UIImage(named: "ligue1A")
        }else {
            bookmarkButton.image = UIImage(named: "hk")
            likeButton.image = UIImage(named: "lumba")
            commentButton.image = UIImage(named: "penang")
            btn4.image = UIImage(named: "macau")
            btn5.image = UIImage(named: "sg")
        }
        
        stackView.addArrangedSubview(bookmarkButton)
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(commentButton)
        stackView.addArrangedSubview(btn4)
        stackView.addArrangedSubview(btn5)
        
        self.contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 1.5).isActive = true
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
    
    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"

         return convertDateFormatter.string(from: oldDate!)
    }

//    (format: "EEEE, MMM d, yyyy", timeZone: (TimeZone(abbreviation: "UTC") ?? TimeZone.current))
}



