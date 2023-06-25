//
//  ViewController.swift
//  spaceX_app
//
//  Created by Aleksandr Mamlygo on 20.06.23.
//

import UIKit

final class MainViewController: UITableViewController {
    
    var rockets: [Rocket] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRockets()
    }
    
    //MARK: Table view controller data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rockets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rocketCell", for: indexPath)
        let rocket = rockets[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = rocket.name
        cell.contentConfiguration = content
        return cell
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let rocketsVC = segue.destination as? RocketViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        rocketsVC.rocket = rockets[indexPath.row]
    }
    
}

// MARK: - Networking
private extension MainViewController {
    func fetchRockets() {
        NetworkManager.shared.fetchRockets { [weak self] result in
            switch result {
            case .success(let rockets):
                self?.rockets = rockets
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
