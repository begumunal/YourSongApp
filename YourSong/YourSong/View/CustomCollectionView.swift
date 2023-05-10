//
//  CustomCollectionView.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import Foundation
import UIKit

class CustomCollectionView: UICollectionView{
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var model : AnyObject
    
    init(model : AnyObject) {
        
        self.model = model 

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = AppColors.primaryColor
        delegate = self
        dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


