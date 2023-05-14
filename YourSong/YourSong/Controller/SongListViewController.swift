//
//  SongListViewController.swift
//  YourSong
//
//  Created by Begum Unal on 11.05.2023.
//

import UIKit

class SongListViewController: UIViewController {

    var selectedIndexId : Int?
    var toolBarTitle : String?
    private let toolBar = CustomToolbar()
    private var albumDetail : CustomTableView!
    private let networkManager = NetworkManager()
    private let customTableViewCell = CustomTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    private func setup(){
        navigationController?.navigationBar.tintColor = AppColors.secondaryPrimaryColor
        self.toolBar.setTitle(title: toolBarTitle!)
        self.toolBar.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.primaryColor
        view.addSubview(toolBar)
       
        NSLayoutConstraint.activate([
            toolBar.topAnchor.constraint(equalTo: view.topAnchor),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.heightAnchor.constraint(equalToConstant: 90),
           
        ])

        fetchArtistDetail()
    }
    private func fetchArtistDetail(){
        guard let id = selectedIndexId else{ return }
        networkManager.fetchData(urlString: Constants.baseUrl + Constants.endpointForAlbumDetail + "/\(id)/tracks", decodingType: SongModel.self) { (result: Result<SongModel, Error>) in
            switch result {
            case .success(let model):
              
                DispatchQueue.main.async {
                    self.albumDetail = CustomTableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .plain, model: model)
                    //self.customTableViewCell.customView.likeButton.addTarget(self, action: #selector(self.likeButtonTapped(_:model:)), for: .touchUpInside)

                    self.albumDetail.translatesAutoresizingMaskIntoConstraints = false
                    
                    self.view.addSubview(self.albumDetail)
                   
                    NSLayoutConstraint.activate([
                        self.albumDetail.topAnchor.constraint(equalTo: self.toolBar.bottomAnchor),
                        self.albumDetail.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                        self.albumDetail.widthAnchor.constraint(equalToConstant: self.view.frame.width),
                        self.albumDetail.heightAnchor.constraint(equalToConstant: self.view.frame.height)
                        
                    ])
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
   /* @objc func likeButtonTapped(_ sender: UIButton, model: SongModel) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if checkDatabase(id: model.data[indexPath.row].id){
            self.customTableViewCell.customView.likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        }else{
            self.customTableViewCell.customView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }*/
    func checkDatabase(id: Int) -> Bool{
        let coreDataManager = CoreDataManager()
        if coreDataManager.fetchData(withId: id, deviceID: UIDevice.current.identifierForVendor!.uuidString) != nil {
            // Veri daha önce kaydedilmiş, silme işlemi yapılacak
            coreDataManager.deleteData(withId: id, deviceID: UIDevice.current.identifierForVendor!.uuidString)
            return true
        } else {
            // Veri daha önce kaydedilmemiş, kaydetme işlemi yapılacak
            coreDataManager.saveData(withId: id, deviceID: UIDevice.current.identifierForVendor!.uuidString, isLiked: true)
            return false
        }

    }
}
