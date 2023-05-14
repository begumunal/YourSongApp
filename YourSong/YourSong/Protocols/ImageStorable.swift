//
//  ImageProtocol.swift
//  YourSong
//
//  Created by Begum Unal on 14.05.2023.
//

import Foundation
import UIKit

protocol ImageStorable{
    var storedImage: UIImage? { get set }
    
    func setImage(_ image: UIImage?)
}

extension ImageStorable {
    mutating func setImage(_ image: UIImage?) {
        storedImage = image
    }
}
