//
//  ViewController.swift
//  spaceX_app
//
//  Created by Aleksandr Mamlygo on 20.06.23.
//

import UIKit

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRockets()
    }
}

// MARK: - Networking
private extension MainViewController {
    func fetchRockets() {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let rockets = try decoder.decode([Rocket].self, from: data)
                print(rockets)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
