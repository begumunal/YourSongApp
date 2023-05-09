//
//  CustomCollectionView.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import Foundation
import UIKit

class CustomCollectionView : UICollectionView{
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private let model : CollectionModel!
    
    init(model : CollectionModel) {
        
        self.model = model

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = AppColors.primaryColor
        delegate = self
        dataSource = self
        
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomCollectionView : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
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
        return model.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: Constants.customCellID)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.customCellID, for: indexPath) as! CustomCollectionViewCell
        
       
        cell.label.text = model.data[indexPath.row].name
        if let url = URL(string: model.data[indexPath.row].picture){
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    cell.imageView.image = image
                }
            }
        }
        
        return cell
    }
}
