//
//  ArtistDetailViewController.swift
//  YourSong
//
//  Created by Begum Unal on 10.05.2023.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    var selectedIndexId : Int?
    private var artistDetail : CustomTableView!
    private let networkManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    private func setup(){
        self.view.backgroundColor = AppColors.primaryColor
        fetchArtistDetail()
    }
    private func fetchArtistDetail(){
        guard let id = selectedIndexId else{ return }
        networkManager.fetchData(urlString: Constants.baseUrl + Constants.endpointForArtistDetail + "/\(id)", decodingType: AlbumDatum.self) { (result: Result<AlbumDatum, Error>) in
            switch result {
            case .success(let model):
                
                DispatchQueue.main.async {
                    self.artistDetail = CustomTableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .plain, model: model)
                    
                    self.artistDetail.translatesAutoresizingMaskIntoConstraints = false
                    
                    self.view.addSubview(self.artistDetail)
                   
                    NSLayoutConstraint.activate([
                        self.artistDetail.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
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
