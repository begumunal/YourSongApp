//
//  ArtistDetailViewController.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import UIKit

class AlbumListViewController: UIViewController {
    var selectedIndexId : Int?
    var toolBarTitle : String?
    var artistMainImage : UIImage?
    private let toolBar = CustomToolbar()
    private var artistDetail : CustomTableView!
    private let networkManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    private func setup(){
        self.toolBar.setTitle(title: toolBarTitle!)
        self.toolBar.backButton.setImage(UIImage(systemName: Constants.backButtonSystemName), for: .normal)
        //toolBar.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.toolBar.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.primaryColor
        view.addSubview(toolBar)
        
        NSLayoutConstraint.activate([
            toolBar.topAnchor.constraint(equalTo: view.topAnchor),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.heightAnchor.constraint(equalToConstant: 90)
        ])

        fetchArtistDetail()
    }
    private func fetchArtistDetail(){
        guard let id = selectedIndexId else{ return }
        networkManager.fetchData(urlString: Constants.baseUrl + Constants.endpointForArtistDetail + "/\(id)/albums", decodingType: AlbumModel.self) { (result: Result<AlbumModel, Error>) in
            switch result {
            case .success(let model):
                
                DispatchQueue.main.async {
                    self.artistDetail = CustomTableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .plain, model: model)
                    
                    self.artistDetail.translatesAutoresizingMaskIntoConstraints = false
                    
                    self.view.addSubview(self.artistDetail)
                   
                    NSLayoutConstraint.activate([
                        self.artistDetail.topAnchor.constraint(equalTo: self.toolBar.bottomAnchor),
                        self.artistDetail.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                        self.artistDetail.widthAnchor.constraint(equalToConstant: self.view.frame.width),
                        self.artistDetail.heightAnchor.constraint(equalToConstant: self.view.frame.height)
                    ])
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
