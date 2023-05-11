//
//  CustomToolBar.swift
//  YourSong
//
//  Created by Begum Unal on 11.05.2023.
//

import Foundation
import UIKit


class CustomToolbar: UIToolbar {
    var backButton = UIButton()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = AppColors.secondaryPrimaryColor
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        // Background color
        self.barTintColor = AppColors.secondaryTintColor
        
        backButton.tintColor = AppColors.secondaryPrimaryColor
        backButton.isUserInteractionEnabled = true 
        self.addSubview(titleLabel)
        self.addSubview(backButton)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
        
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // Set title text
    func setTitle(title: String) {
        titleLabel.text = title
    }
   
}
