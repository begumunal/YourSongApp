//
//  TableViewExtention.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import Foundation
import UIKit

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
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let model = model as? AlbumModel{
            if indexPath.row == 0{
                _ = CustomTableViewFirstCell(style: .default, reuseIdentifier: Constants.customTableFirstCellID)
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customTableFirstCellID, for: indexPath) as! CustomTableViewFirstCell
                cell.isUserInteractionEnabled = false
                
                return cell
            }else{
                _ = CustomTableViewCell(style: .default, reuseIdentifier: Constants.customTableCellID)
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customTableCellID, for: indexPath) as! CustomTableViewCell
                cell.isUserInteractionEnabled = true
                cell.customView.nameLabel.text = model.data[indexPath.row].title
                cell.customView.infoLabel.text = model.data[indexPath.row].releaseDate
                if checkDatabase(id: model.data[indexPath.row].id){
                    cell.customView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }else{
                    cell.customView.likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                }
                if let url = URL(string: model.data[indexPath.row].coverSmall){
                    loadImage(from: url) { image in
                        DispatchQueue.main.async {
                            cell.imageView!.image = image
                        }
                       
                    }
                }
                return cell
            }
        }else if let model = model as? SongModel{
            _ = CustomTableViewCell(style: .default, reuseIdentifier: Constants.customTableCellID)
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customTableCellID, for: indexPath) as! CustomTableViewCell
            cell.isUserInteractionEnabled = true
            cell.customView.nameLabel.text = model.data[indexPath.row].title
            if let url = URL(string: " https://e-cdns-images.dzcdn.net/images/cover/\(model.data[indexPath.row].md5Image)/56x56-000000-80-0-0.jpg"){
                loadImage(from: url) { image in
                    DispatchQueue.main.async {
                        cell.imageView!.image = image
                    }
                }
            }
            return cell
        }
        else{
            _ = CustomTableViewCell(style: .default, reuseIdentifier: Constants.customTableCellID)
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customTableCellID, for: indexPath) as! CustomTableViewCell
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
            nextVC.toolBarTitle = model.data[indexPath.row].title
            nextVC.selectedIndexId = model.data[indexPath.row].id
            guard let navController = albumListVC.navigationController else { return }
            navController.setViewControllers([nextVC], animated: true)
           
        }else if let model = model as? SongModel{
            //TIKLANAN ŞARKININ KISA BİR DİNLEMESİ OLACAK
        }
        
        
      
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let model = model as? AlbumModel{
            if indexPath.row == 0{
                return 200
            }else{
                return 76 // hücre yüksekliği
            }
        }else{
            return 76
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // hücreler arasındaki boşluk yüksekliği
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }.resume()
    }
    
    func checkDatabase(id: Int) -> Bool{
        let coreDataManager = CoreDataManager()
        if coreDataManager.fetchData(withId: id, deviceID: UIDevice.current.identifierForVendor!.uuidString) != nil {
            // Veri daha önce kaydedilmiş, silme işlemi yapılacak
            coreDataManager.deleteData(withId: id, deviceID: UIDevice.current.identifierForVendor!.uuidString)
            return true
        } else {
            // Veri daha önce kaydedilmemiş, kaydetme işlemi yapılacak
            coreDataManager.saveData(withId: id, deviceID: UIDevice.current.identifierForVendor!.uuidString, isLiked: true)
            return false
        }

    }
}
