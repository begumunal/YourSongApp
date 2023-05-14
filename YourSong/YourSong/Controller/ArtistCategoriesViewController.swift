//
//  SingerCategoriesViewController.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import UIKit

class ArtistCategoriesViewController: UIViewController {
    private let toolbar = CustomToolbar()
    var toolBarTitle : String?
    var selectedCellID : Int?
    private let networkManager = NetworkManager()
    private var singerCategoriesCollection : CustomCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    private func setup(){
        navigationController?.navigationBar.tintColor = AppColors.secondaryPrimaryColor
        self.toolbar.setTitle(title: toolBarTitle!)
        self.toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.primaryColor
        view.addSubview(toolbar)
        
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 90)
        ])
        self.fetchArtists()
    }
    private func fetchArtists(){
       
        guard let id = selectedCellID else{ return }
        networkManager.fetchData(urlString: Constants.baseUrl + Constants.endpointForMusics + "/\(id)" + Constants.endpointForArtists, decodingType: ArtistModel.self) { (result: Result<ArtistModel, Error>) in
            switch result {
            case .success(let model):
                
                DispatchQueue.main.async {
                    self.singerCategoriesCollection = CustomCollectionView(model: model)
                    self.singerCategoriesCollection.translatesAutoresizingMaskIntoConstraints = false
                    
                    self.view.addSubview(self.singerCategoriesCollection)
                   
                    NSLayoutConstraint.activate([
                        self.singerCategoriesCollection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                        self.singerCategoriesCollection.topAnchor.constraint(equalTo: (self.toolbar.bottomAnchor)),
                        self.singerCategoriesCollection.widthAnchor.constraint(equalToConstant: self.view.frame.width),
                        self.singerCategoriesCollection.heightAnchor.constraint(equalToConstant: self.view.frame.height)
                    ])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
   
}
