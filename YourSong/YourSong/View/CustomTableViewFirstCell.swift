//
//  CustomTableViewFirstCell.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import Foundation
import UIKit

class CustomTableViewFirstCell: UITableViewCell {
    
    let artistMainImage = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {

        self.artistMainImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(artistMainImage)

        NSLayoutConstraint.activate([
            artistMainImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            artistMainImage.topAnchor.constraint(equalTo: topAnchor),
            artistMainImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            artistMainImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    
    }
}

