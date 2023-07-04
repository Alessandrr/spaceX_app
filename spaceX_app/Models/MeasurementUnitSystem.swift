//
//  MeasurementUnitSystem.swift
//  spaceX_app
//
//  Created by Aleksandr Mamlygo on 25.06.23.
//

import Foundation

enum MassUnit: Codable {
    case kg
    case lbs
}

enum DistanceUnit: Codable {
    case meters
    case feet
}

struct MeasurementUnitSystem: Codable {
    var massUnit: MassUnit
    var distanceUnit: DistanceUnit
}
