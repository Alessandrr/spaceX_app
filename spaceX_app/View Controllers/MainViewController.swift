//
//  ViewController.swift
//  spaceX_app
//
//  Created by Aleksandr Mamlygo on 20.06.23.
//

import UIKit

final class MainViewController: UITableViewController {
    
    var rockets: [Rocket] = []
    var activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
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
        guard let rocketVC = segue.destination as? RocketViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        rocketVC.rocket = rockets[indexPath.row]
    }
    
    //MARK: - Private functions
    func setupActivityIndicator() {
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
    }
    
}

// MARK: - Networking
private extension MainViewController {
    func fetchRockets() {
        NetworkManager.shared.fetchRockets { [weak self] result in
            switch result {
            case .success(let rockets):
                self?.rockets = rockets
                self?.activityIndicatorView.stopAnimating()
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
