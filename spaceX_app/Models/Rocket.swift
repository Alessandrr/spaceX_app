//
//  Rocket.swift
//  spaceX_app
//
//  Created by Aleksandr Mamlygo on 20.06.23.
//

struct Rocket: Decodable {
    let name: String
    let type: String
    let active: Bool
    let stages: Int
    let boosters: Int
    let costPerLaunch: Int
    let successRatePct: Int
    let firstFlight: String
    let country: String
    let company: String
    let wikipedia: String
    let description: String
    let id: String
    let flickrImages: [String]
    
    let height: Height
    let diameter: Diameter
    let mass: Mass
}

struct Height: Decodable {
    let meters: Double
    let feet: Double
}

struct Diameter: Decodable {
    let meters: Double
    let feet: Double
}

struct Mass: Decodable {
    let kg: Int
    let lb: Int
}

