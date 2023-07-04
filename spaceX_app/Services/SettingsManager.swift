//
//  SettingsManager.swift
//  spaceX_app
//
//  Created by Aleksandr Mamlygo on 04.07.23.
//

import Foundation

class SettingsManager {
    private let defaults = UserDefaults.standard
    private let settingsKey = "settings"
    
    static let shared = SettingsManager()
    
    private init() {}
    
    func changeSettings(massUnit: MassUnit, distanceUnit: DistanceUnit) {
        let settings = MeasurementUnitSystem(massUnit: massUnit, distanceUnit: distanceUnit)
        guard let settingsData = try? JSONEncoder().encode(settings) else { return }
        defaults.set(settingsData, forKey: settingsKey)
    }
    
    func fetchSettings() -> MeasurementUnitSystem {
        guard let defaults = defaults.data(forKey: settingsKey) else {
            return MeasurementUnitSystem(massUnit: .kg, distanceUnit: .meters)
        }
        guard let settings = try? JSONDecoder().decode(MeasurementUnitSystem.self, from: defaults) else {
            return MeasurementUnitSystem(massUnit: .kg, distanceUnit: .meters)
        }
        return settings
    }
}
