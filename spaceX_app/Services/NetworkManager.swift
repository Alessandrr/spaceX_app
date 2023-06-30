//
//  NetworkManager.swift
//  spaceX_app
//
//  Created by Aleksandr Mamlygo on 25.06.23.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decoderError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRockets(completion: @escaping (Result<[Rocket], NetworkError>) -> Void) {
        
        AF.request("https://api.spacexdata.com/v4/rockets")
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    completion(.success(Rocket.getRockets(from: value)))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func fetchRocketImage(from images: [String], completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: images.randomElement() ?? "") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
