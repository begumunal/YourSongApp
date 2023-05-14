//
//  CustomTableViewCell.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import Foundation
import UIKit
import AVFoundation

typealias ButtonTapClosure = (UITableViewCell) -> Void
class CustomTableViewCell: UITableViewCell {
    var player : AVPlayer?
    let customView = CustomTableViewCellDetail()
    var likeButtonTappedClosure: ButtonTapClosure?
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
        customView.likeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
        let buttonRect = customView.likeButton.frame
        if self.bounds.contains(point) && !buttonRect.contains(point) {
            return super.hitTest(point, with: event)
        }
        return nil
    }
    @objc private func buttonTapped(sender: UIButton) {
        if let cell = sender.superview?.superview as? CustomTableViewCell {
            cell.likeButtonTappedClosure?(cell)
        }
    }
}


