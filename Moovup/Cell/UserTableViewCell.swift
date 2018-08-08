//
//  UserTableViewCell.swift
//  Moovup
//
//  Created by Moovup on 07/08/18.
//  Copyright © 2018 Moovup. All rights reserved.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {
    
    let cardView: CardView = {
        let cardView = CardView()
        cardView.cornerRadius = 4.0
        cardView.shadowOpacity = 4.5
        cardView.shadowRadius = 1.0
        cardView.backgroundColor = .white
        return cardView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica Neue", size: 16.0)
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = #imageLiteral(resourceName: "userProfile")
        return imageView
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.addCardView()
        self.addImageView()
        self.addNameLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension UserTableViewCell {
    func addCardView() {
        self.addSubview(self.cardView)
        self.cardView.translatesAutoresizingMaskIntoConstraints = false
        
        self.cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0).isActive = true
        self.cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        self.cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4.0).isActive = true
        self.cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
    }
    
    func addImageView() {
        self.cardView.addSubview(userImageView)
        self.userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.userImageView.topAnchor.constraint(equalTo: self.cardView.topAnchor, constant: 12.0).isActive = true
        self.userImageView.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 8.0).isActive = true
        self.userImageView.bottomAnchor.constraint(equalTo: self.cardView.bottomAnchor, constant: -12.0).isActive = true
        self.userImageView.widthAnchor.constraint(equalToConstant: 36.0).isActive = true
        self.userImageView.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        
        DispatchQueue.main.async {
            self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width / 2.0
            self.userImageView.clipsToBounds = true
        }
    }
    
    func addNameLabel() {
        self.cardView.addSubview(nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.nameLabel.centerYAnchor.constraint(equalTo: self.userImageView.centerYAnchor, constant: 0.0).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.userImageView.trailingAnchor, constant: 8.0).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: 8.0).isActive = true
    }
    
    func configureCell(imageUrl: String, userName: String, indexPath: IndexPath) {
        self.userImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "userProfile"), completed: nil)
        self.cardView.backgroundColor = indexPath.row % 2 == 0 ? AppColor.evenrowColor : AppColor.oddrowColor
        self.nameLabel.text = userName
    }
}
