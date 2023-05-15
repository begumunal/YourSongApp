//
//  CustomTableViewCellDetail.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import Foundation
import UIKit

class CustomTableViewCellDetail: UIView {
    let playingIconImageView = UIImageView(image: UIImage(systemName: "speaker.wave.3"))
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let infoLabel = UILabel()
    let likeButton = UIButton()
   
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
        
        playingIconImageView.contentMode = .scaleAspectFit
        playingIconImageView.translatesAutoresizingMaskIntoConstraints = false
        playingIconImageView.isHidden = true
        playingIconImageView.tintColor = AppColors.secondaryPrimaryColor
        addSubview(playingIconImageView)
        
        likeButton.tintColor = AppColors.primaryTintColor
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.isUserInteractionEnabled = true
        addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 40),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: playingIconImageView.trailingAnchor),
            
           
            infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 40),
            infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            playingIconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playingIconImageView.trailingAnchor.constraint(equalTo: self.likeButton.trailingAnchor, constant: -40),
            playingIconImageView.widthAnchor.constraint(equalToConstant: 32),
            playingIconImageView.heightAnchor.constraint(equalToConstant: 32),
            
            likeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            
            
        ])
    }
}
