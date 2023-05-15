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
    case rightArea
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
            touchedArea = .rightArea
            return self
        } else {
            touchedArea = .cell
            return super.hitTest(point, with: event)
        }
        /*let buttonRect = customView.likeButton.frame
        
        if self.bounds.contains(point) && !buttonRect.contains(point) {
            touchedArea = .cell
            return super.hitTest(point, with: event)
        } else if buttonRect.contains(point) {
            touchedArea = .likeButton
            return customView.likeButton.hitTest(self.convert(point, to: customView.likeButton), with: event)
        }
        
        return nil*/
    }
   /* func handleLikeButtonTapped(onCell cell: CustomTableViewCell) {
        
        if let tableView = cell.superview as? UITableView {
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            //let datum = model.data[indexPath.row]
            if coreDataManager.checkDatabase(id: coreDataManager.id){
                
            }
            if let model = coreDataManager.model as? SongModel{
               /* if coreDataManager.checkDatabase(id: model.data[indexPath.row]){
                    
                }*/
            }
            
        }

    }*/
    
}


