//
//  CustomCollectionViewCell.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import Foundation
import UIKit

class CustomCollectionViewCell : UICollectionViewCell{
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        //label.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        label.textColor = AppColors.primaryTintColor
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // ImageView Constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(label)
        layer.borderWidth = 3.0
        layer.borderColor = AppColors.primaryTintColor?.cgColor
        layer.cornerRadius = 15.0
        let backgroundImage = AppImages.appIconImage
        let context = CIContext(options: nil)
        let ciImage = CIImage(image: backgroundImage!)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(5.0, forKey: kCIInputRadiusKey)
        let result = filter?.value(forKey: kCIOutputImageKey) as! CIImage
        let blurredImage = UIImage(cgImage: context.createCGImage(result, from: result.extent)!)
        self.label.backgroundColor = UIColor(patternImage: blurredImage)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
 
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
}
