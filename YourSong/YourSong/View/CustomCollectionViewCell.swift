//
//  CustomCollectionViewCell.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import Foundation
import UIKit

class CustomCollectionViewCell : UICollectionViewCell{
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.textColor = AppColors.primaryTintColor
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.backgroundColor = AppColors.primaryColor?.withAlphaComponent(0.7)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
       
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(label)
        layer.borderWidth = 3.0
        layer.borderColor = AppColors.secondaryPrimaryColor?.cgColor
        layer.cornerRadius = 15.0
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
 
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            label.widthAnchor.constraint(equalToConstant: 100),
        ])
        
    }
    
}
