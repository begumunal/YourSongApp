//
//  NetworkManager.swift
//  YourSong
//
//  Created by Begum Unal on 9.05.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
}
class NetworkManager{
    
    func fetchData<T: Decodable>(urlString: String, decodingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                let decodedData = try jsonDecoder.decode(decodingType, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    struct APIErrorResponse: Decodable {
        let message: String
    }
    
    
}
