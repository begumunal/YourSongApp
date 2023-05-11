//
//  CustomTableViewCell.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let customView = CustomTableViewCellDetail()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        // Custom görünümü ekleyin
        customView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(customView)
        
        // Görünüm için constraint'leri belirleyin
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            customView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            customView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            customView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            
        ])
        
        // Görünümün kenarlarını kırmızıya boyamak için layer özelliklerini kullanın
        customView.layer.borderWidth = 3
        customView.layer.cornerRadius = 15
        customView.layer.borderColor = AppColors.secondaryPrimaryColor?.cgColor
    }
}


