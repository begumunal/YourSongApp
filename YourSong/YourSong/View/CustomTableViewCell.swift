//
//  CustomTableViewCell.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import Foundation
import UIKit
import AVFoundation

enum TouchedArea {
    case cell
    case likeButton
    
}

typealias ButtonTapClosure = (UITableViewCell) -> Void
class CustomTableViewCell: UITableViewCell {
    
    var touchedArea: TouchedArea = .cell
    let coreDataManager = CoreDataManager()
    var player : AVPlayer?
    let customView = CustomTableViewCellDetail()
    override func prepareForReuse() {
        super.prepareForReuse()
        customView.playingIconImageView.isHidden = true
        player?.pause()
        player = nil
    }
    func showPlayingIcon() {
        customView.playingIconImageView.isHidden = false
    }
    func hidePlayingIcon() {
        customView.playingIconImageView.isHidden = true
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        self.backgroundColor = AppColors.primaryColor
        customView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(customView)

        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            customView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            customView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            customView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        customView.layer.borderWidth = 3
        customView.layer.cornerRadius = 15
        customView.layer.borderColor = AppColors.secondaryPrimaryColor?.cgColor
    }
  
    //like butonuna tıkladıysan aynı zamanda cell e tıklanmış olmaması için yazdığım fonk.
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let touchAreaRect = CGRect(x: self.bounds.width - 40, y: 0, width: 40, height: self.bounds.height)
        if touchAreaRect.contains(point) {
            touchedArea = .likeButton
            return self
        } else {
            touchedArea = .cell
            return super.hitTest(point, with: event)
        }
     
    }
  
}


