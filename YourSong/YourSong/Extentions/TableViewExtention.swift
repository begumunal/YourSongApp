//
//  TableViewExtention.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import Foundation
import UIKit
import AVFoundation

enum TableModel{
    case AlbumModel
    case SongModel
    
}
extension CustomTableView : UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let model = model as? AlbumModel{
            return model.data.count + 1
        }else if let model = model as? SongModel{
            return model.data.count
        }
        else{
            if let result = coreDataManager.fetchCoreDataObjects(){
                return result.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let model = model as? AlbumModel{
            if indexPath.row == 0{
                _ = CustomTableViewFirstCell(style: .default, reuseIdentifier: Constants.customTableFirstCellID)
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customTableFirstCellID, for: indexPath) as! CustomTableViewFirstCell
                cell.isUserInteractionEnabled = false
                let notificationCenter = NotificationCenter.default
                
                DispatchQueue.main.async {
                   
                    cell.artistMainImage.image = AppImages.artistMainImage
                }
               
                return cell
            }else{
                _ = CustomTableViewCell(style: .default, reuseIdentifier: Constants.customTableCellID)
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customTableCellID, for: indexPath) as! CustomTableViewCell
                cell.isUserInteractionEnabled = true
                cell.customView.nameLabel.text = model.data[indexPath.row-1].title
                cell.customView.infoLabel.text = model.data[indexPath.row-1].releaseDate
                
                if let url = URL(string: model.data[indexPath.row-1].coverSmall){
                    loadImage(from: url) { image in
                        cell.imageView?.image = image
                    }
                }
                return cell
            }
        }else if let model = model as? SongModel{
            
            _ = CustomTableViewCell(style: .default, reuseIdentifier: Constants.customTableCellID)
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customTableCellID, for: indexPath) as! CustomTableViewCell
            cell.isUserInteractionEnabled = true
            cell.customView.nameLabel.text = model.data[indexPath.row].title
            cell.customView.likeButton.tag = indexPath.row
            cell.customView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.customView.infoLabel.text = formatDuration(seconds: (model.data[indexPath.row].duration))
            let md5image = model.data[indexPath.row].md5Image
            if let url = URL(string: "https://e-cdns-images.dzcdn.net/images/cover/\(md5image)/56x56-000000-80-0-0.jpg") {
                loadImage(from: url) { image in
                    cell.imageView?.image = image
                }
            }
          
            if coreDataManager.onlyCheckDatabase(id: model.data[indexPath.row].id){
                cell.customView.likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            }else{
                cell.customView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            return cell
        }
        else{
            _ = CustomTableViewCell(style: .default, reuseIdentifier: Constants.customTableCellID)
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customTableCellID, for: indexPath) as! CustomTableViewCell
            if let result = coreDataManager.fetchCoreDataObjects(){
   
                networkManager.fetchData(urlString: "https://api.deezer.com/track/\(result[indexPath.row].id)", decodingType: SongDatum.self) {(result: Result<SongDatum, Error>)  in
                    switch result {
                    case .success(let model):
                        
                        DispatchQueue.main.async {
                            cell.customView.nameLabel.text = model.title
                            cell.customView.infoLabel.text = self.formatDuration(seconds: (model.duration))
                            let md5image = model.md5Image
                            if let url = URL(string: "https://e-cdns-images.dzcdn.net/images/cover/\(md5image)/56x56-000000-80-0-0.jpg") {
                                self.loadImage(from: url) { image in
                                    cell.imageView?.image = image
                                }
                            }
                            cell.customView.likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            }
            return cell
        }
 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.allowsSelection = true
        tableView.delegate = self
        if let model = model as? AlbumModel{
            guard let albumListVC = self.traverseResponderChain(for: AlbumListViewController.self) else {
                return
            }
            let nextVC = SongListViewController()
            nextVC.toolBarTitle = model.data[indexPath.row-1].title
            nextVC.selectedIndexId = model.data[indexPath.row-1].id
            guard let navController = albumListVC.navigationController else { return }
            navController.pushViewController(nextVC, animated: true)
           
        }else if let model = model as? SongModel{
           
            let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell
            
            
            if cell?.touchedArea == .cell{
                let datum = model.data[indexPath.row]
                
                guard let previewURL = URL(string: datum.preview) else { return }
                let playerItem = AVPlayerItem(url: previewURL)
                
                
                cell?.player = AVPlayer(playerItem: playerItem)
                cell?.showPlayingIcon()

                cell?.player?.play()
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: nil) { [weak self] notification in
                    cell?.hidePlayingIcon()
                }
            }else if cell?.touchedArea == .likeButton{
                if coreDataManager.checkDatabase(id: model.data[indexPath.row].id){
                    cell?.customView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }else{
                    cell?.customView.likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                }
            }
            
        }else{
            if let result = coreDataManager.fetchCoreDataObjects(){
                
                let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell
                
                if cell?.touchedArea == .cell{
                    
                }else if cell?.touchedArea == .likeButton{
                    if coreDataManager.checkDatabase(id: Int(result[indexPath.row].id)){
                        cell?.customView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                        
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }else{
                        cell?.customView.likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                        
                    }
                }
                
            }
           
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if model is AlbumModel{
            if indexPath.row == 0{
                return 300
            }else{
                return 85 // hücre yüksekliği
            }
        }else{
            return 85
        }   
    }
    
    //görüntüler çok geç yüklendiği için buna çözüm olarak imageleri önbelleğe almayı gerçekleştirdiğim fonk.
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache[url.absoluteString] {
            completion(cachedImage)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            self.imageCache[url.absoluteString] = image
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }

    func formatDuration(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
    }
   
}
