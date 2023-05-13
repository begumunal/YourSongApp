//
//  NetworkService.swift
//  YourSong
//
//  Created by Begum Unal on 12.05.2023.
//

import Foundation

class NetworkService{
    let networkManager = NetworkManager()
    func fetchDFata<T: Decodable>(endpoint: String, decodingType: T.Type){
        networkManager.fetchData(urlString: Constants.baseUrl + endpoint, decodingType: MusicModel.self) { (result: Result<MusicModel, Error>) in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
   
}
