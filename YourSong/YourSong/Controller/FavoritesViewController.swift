//
//  FavoritesViewController.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    private var likedTables : CustomTableView!
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
        
        fetchFavoritesData()
    }
    
    private func fetchFavoritesData(){
        DispatchQueue.main.async {
            let model = LikedItem()
            self.likedTables = CustomTableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .plain, model: model)
            
            self.likedTables.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(self.likedTables)
           
            NSLayoutConstraint.activate([
                self.likedTables.topAnchor.constraint(equalTo: self.toolbar.bottomAnchor),
                self.likedTables.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                self.likedTables.widthAnchor.constraint(equalToConstant: self.view.frame.width),
                self.likedTables.heightAnchor.constraint(equalToConstant: self.view.frame.height)
                
            ])
        }
    
    }

}
