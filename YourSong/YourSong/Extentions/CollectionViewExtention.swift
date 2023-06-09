//
//  CollectionViewExtention.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import Foundation
import UIKit

extension CustomCollectionView : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let model = model as? MusicModel{
            return model.data.count
        }
        if let model = model as? ArtistModel{
            return model.data.count
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: Constants.customCollectionCellID)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.customCollectionCellID, for: indexPath) as! CustomCollectionViewCell
        
        if let model = model as? MusicModel{
            cell.label.text = model.data[indexPath.row].name
            if let url = URL(string: model.data[indexPath.row].pictureMedium){
                loadImage(from: url) { image in
                    cell.imageView.image = image
                }
            }
        }
        if let model = model as? ArtistModel{
            cell.label.text = model.data[indexPath.row].name
            if let url = URL(string: model.data[indexPath.row].pictureMedium){
                loadImage(from: url) { image in
                    cell.imageView.image = image
                }
            }
        }
        
        return cell
    }
}


extension CustomCollectionView : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = model as? MusicModel{
            let selectedCellID = model.data[indexPath.row].id
            guard let musicCategoriesVC = self.traverseResponderChain(for: MusicCategoriesViewController.self) else {
                return
            }
            let nextVC = ArtistCategoriesViewController()
            nextVC.selectedCellID = selectedCellID
            nextVC.toolBarTitle = model.data[indexPath.row].name
            guard let navController = musicCategoriesVC.navigationController else { return }
            navController.pushViewController(nextVC, animated: true)
            

        }
        if let model = model as? ArtistModel{
            let selectedCellID = model.data[indexPath.row].id
            if let url = URL(string: model.data[indexPath.row].pictureBig){
                loadImage(from: url) { image in
                    //let notificationCenter = NotificationCenter.default
                    AppImages.artistMainImage = image!
                    //notificationCenter.post(name: Notification.Name("SelectedImageDidChange"), object: nil, userInfo: ["selectedImage": image!])
                }
            }
            guard let artistCategoriesVC = self.traverseResponderChain(for: ArtistCategoriesViewController.self) else {
                return
            }
            let nextVC = AlbumListViewController()
            nextVC.selectedIndexId = selectedCellID
            nextVC.toolBarTitle = model.data[indexPath.row].name
           
            guard let navController = artistCategoriesVC.navigationController else { return }
            navController.pushViewController(nextVC, animated: true)
        }
    }
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = self.imageCache[url.absoluteString] {
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
    
}


extension UIResponder {
    func traverseResponderChain<T: UIResponder>(for type: T.Type) -> T? {
        var next = self.next
        while next != nil {
            if let found = next as? T {
                return found
            }
            next = next?.next
        }
        return nil
    }
}



