//
//  SingerCategoriesViewController.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import UIKit

class ArtistCategoriesViewController: UIViewController {
    var selectedCellID : Int?
    private let networkManager = NetworkManager()
    private var singerCategoriesCollection : CustomCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    private func setup(){
        view.backgroundColor = AppColors.primaryColor
        self.fetchSinger()
    }
    private func fetchSinger(){
       
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
