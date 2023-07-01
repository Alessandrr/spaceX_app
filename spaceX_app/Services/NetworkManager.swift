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
    
    func fetchRocketsDecodable(completion: @escaping (Result<[Rocket], AFError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request("https://api.spacexdata.com/v4/rockets")
            .validate()
            .responseDecodable(of: [Rocket].self, decoder: decoder) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
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
        AF.request(images.randomElement() ?? "")
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
