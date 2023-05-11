//
//  FavoritesViewController.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    private let toolbar = CustomToolbar()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    private func setup(){
        self.toolbar.setTitle(title: Constants.FavoritesViewControllerTitle)
        self.toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.primaryColor
        view.addSubview(toolbar)
        
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    

}
