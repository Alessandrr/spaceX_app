//
//  RocketViewController.swift
//  spaceX_app
//
//  Created by Aleksandr Mamlygo on 25.06.23.
//

import UIKit

class RocketViewController: UIViewController {
    
    var rocket: Rocket!

    //MARK: - IBOutlets
    @IBOutlet var rocketImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var diameterLabel: UILabel!
    @IBOutlet var massLabel: UILabel!
    @IBOutlet var costLabel: UILabel!
    @IBOutlet var successRateLabel: UILabel!
    @IBOutlet var firstLaunchLabel: UILabel!
    
    //MARK: - VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        setupRocketImage()
        setupRocketInfo()
        setupMeasurementsInfo()
    }
    
    //MARK: - IBActions
    @IBAction func infoButtonPressed() {
        guard let wikiUrl = URL(string: rocket.wikipedia) else { return }
        
        if UIApplication.shared.canOpenURL(wikiUrl) {
            UIApplication.shared.open(wikiUrl)
        }
    }
    
    @IBAction func unitSystemSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            MeasurementUnitSystem.shared.distanceUnit = .meters
            MeasurementUnitSystem.shared.massUnit = .kg
        default:
            MeasurementUnitSystem.shared.distanceUnit = .feet
            MeasurementUnitSystem.shared.massUnit = .lbs
        }
        
        setupMeasurementsInfo()
    }
    
    //MARK: - Private functions
    private func setupRocketImage() {
        NetworkManager.shared.fetchRocketImage(from: rocket.flickrImages) { [weak self] result in
            switch result {
            case .success(let rocketImage):
                self?.rocketImageView.contentMode = .scaleAspectFill
                self?.rocketImageView.image = UIImage(data: rocketImage)
            case .failure(let error):
                print(error.localizedDescription)
                self?.rocketImageView.contentMode = .center
                self?.rocketImageView.image = UIImage(systemName: "exclamationmark")
            }
            
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func setupRocketInfo() {
        navigationItem.title = rocket.name
        
        costLabel.text = "Cost per launch: \(rocket.costPerLaunch) USD"
        successRateLabel.text = "Launch success rate: \(rocket.successRatePct)%"
        firstLaunchLabel.text = "First flight: \(rocket.firstFlight)"
    }
    
    private func setupMeasurementsInfo() {
        switch MeasurementUnitSystem.shared.massUnit {
        case .kg:
            massLabel.text = "Mass: \(rocket.mass.kg) kg"
        case .lbs:
            massLabel.text = "Mass: \(rocket.mass.lb) lbs"
        }
        
        switch MeasurementUnitSystem.shared.distanceUnit {
        case .meters:
            heightLabel.text = "Height \(rocket.height.meters) m"
            diameterLabel.text = "Diameter: \(rocket.diameter.meters) m"
        case .feet:
            heightLabel.text = "Height \(rocket.height.feet) ft"
            diameterLabel.text = "Diameter: \(rocket.diameter.feet) ft"
        }
    }
    
}
