//
//  CustomTableViewCellDetail.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import Foundation
import UIKit

class CustomTableViewCellDetail: UIView {
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let infoLabel = UILabel()
    let likeButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
    
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont.systemFont(ofSize: 11)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(infoLabel)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 40),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 40),
            infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            likeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            likeButton.widthAnchor.constraint(equalToConstant: 32),
            likeButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
