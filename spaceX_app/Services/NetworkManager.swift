//
//  NetworkManager.swift
//  spaceX_app
//
//  Created by Aleksandr Mamlygo on 25.06.23.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decoderError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRockets(completion: @escaping (Result<[Rocket], NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.invalidUrl))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(rockets))
                }
            } catch let error {
                print(error)
                completion(.failure(.decoderError))
            }
            
        }.resume()
    }
    
    func fetchRocketImage(from images: [String], completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: images.randomElement() ?? "") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
