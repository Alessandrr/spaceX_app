//
//  MeasurementUnitSystem.swift
//  spaceX_app
//
//  Created by Aleksandr Mamlygo on 25.06.23.
//

import Foundation

enum MassUnit {
    case kg
    case lbs
}

enum DistanceUnit {
    case meters
    case feet
}

class MeasurementUnitSystem {
    static let shared = MeasurementUnitSystem()
    
    var massUnit: MassUnit
    var distanceUnit: DistanceUnit
    
    private init() {
        massUnit = .kg
        distanceUnit = .meters
    }
}
