//
//  LoadingIconView.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import Foundation
import UIKit

class LoadingIconView{
    static let shared = LoadingIconView()
    private let containerView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    
    private init() {
        containerView.frame = UIScreen.main.bounds
        containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = containerView.center
        
        containerView.addSubview(activityIndicator)
    }
    
    func show() {
        guard let currentWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        currentWindow.addSubview(containerView)
    }
    
    func hide() {
        containerView.removeFromSuperview()
    }
}
