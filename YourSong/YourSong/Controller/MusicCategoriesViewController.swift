//
//  MusicCategoriesViewController.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import UIKit

class MusicCategoriesViewController: UIViewController {
    private let toolbar = CustomToolbar()

    private let networkManager = NetworkManager()
    private var musicCategoriesCollection : CustomCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        
        
    }
    
    private func setup(){
       
        self.toolbar.setTitle(title: Constants.MusicCategoriesViewControllerTitle)
        self.toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.primaryColor
        view.addSubview(toolbar)
       
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        self.fetchMusics()
        
    }

    
    private func fetchMusics(){
       
        networkManager.fetchData(urlString: Constants.baseUrl + Constants.endpointForMusics, decodingType: MusicModel.self) { (result: Result<MusicModel, Error>) in
            switch result {
            case .success(let model):
                
                DispatchQueue.main.async {
                    self.musicCategoriesCollection = CustomCollectionView(model: model)
                    
                    self.musicCategoriesCollection.translatesAutoresizingMaskIntoConstraints = false
                    
                    self.view.addSubview(self.musicCategoriesCollection)
                   
                    NSLayoutConstraint.activate([
                        self.musicCategoriesCollection.topAnchor.constraint(equalTo: self.toolbar.bottomAnchor),
                        self.musicCategoriesCollection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                        self.musicCategoriesCollection.widthAnchor.constraint(equalToConstant: self.view.frame.width),
                        self.musicCategoriesCollection.heightAnchor.constraint(equalToConstant: self.view.frame.height)
                    ])
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }

}
