//
//  MusicCategoriesViewController.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import UIKit

class MusicCategoriesViewController: UIViewController {
    private let toolbar = UIToolbar()
    private let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))

    private let networkManager = NetworkManager()
    private var musicCategoriesCollection : CustomCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    private func setup(){
        view.backgroundColor = AppColors.primaryColor
        self.toolbar.tintColor = AppColors.primaryTintColor
        self.toolbar.barTintColor = .orange
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Başlık"
        titleLabel.textAlignment = .center
        let titleBarButton = UIBarButtonItem(customView: titleLabel)
        let flexibleSpaceBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpaceBarButton, titleBarButton, flexibleSpaceBarButton], animated: false)
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        self.fetchMusics()
    }

    
    private func fetchMusics(){
       
        networkManager.fetchData(urlString: Constants.urlForMusics, decodingType: CollectionModel.self) { (result: Result<CollectionModel, Error>) in
            switch result {
            case .success(let model):
                
                DispatchQueue.main.async {
                    self.musicCategoriesCollection = CustomCollectionView(model: model)
                    self.musicCategoriesCollection.translatesAutoresizingMaskIntoConstraints = false
                    
                    self.view.addSubview(self.musicCategoriesCollection)
                    
                    NSLayoutConstraint.activate([
                        self.musicCategoriesCollection.topAnchor.constraint(equalTo: self.toolbar.bottomAnchor),
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
