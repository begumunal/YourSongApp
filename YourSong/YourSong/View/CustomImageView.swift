//
//  CustomImageView.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import Foundation
import UIKit

class CustomImageView : UIImageView{
    
    override init(image: UIImage?) {
        guard let image = image else {
            fatalError("Image not found!")
        }
        
        super.init(image: image)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
