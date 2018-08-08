//
//  UserDetailTableViewCell.swift
//  Moovup
//
//  Created by TechFlitter Solutions on 07/08/18.
//  Copyright © 2018 Moovup. All rights reserved.
//

import UIKit

import SDWebImage

class UserDetailTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica Neue", size: 16.0)
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
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
        self.addImageView()
        self.addNameLabel()
        self.addEmailLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension UserDetailTableViewCell {
    func addImageView() {
        self.addSubview(userImageView)
        self.userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.userImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12.0).isActive = true
        self.userImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        self.userImageView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        self.userImageView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true

        DispatchQueue.main.async {
            self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width / 2.0
            self.userImageView.clipsToBounds = true
        }
    }
    
    func addNameLabel() {
        self.addSubview(nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.topAnchor.constraint(equalTo: self.userImageView.bottomAnchor, constant: 20.0).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
    }
    
    func addEmailLabel() {
        self.addSubview(emailLabel)
        self.emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emailLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8.0).isActive = true
        self.emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        self.emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        self.emailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0).isActive = true
    }
    
    func configureCell(imageUrl: String, userName: String, email: String) {
        self.userImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "userProfile"), completed: nil)
        self.nameLabel.text = "Name: " + userName
        self.emailLabel.text = "Email: " + email
    }
}
