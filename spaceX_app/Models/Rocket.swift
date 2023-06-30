//
//  Rocket.swift
//  spaceX_app
//
//  Created by Aleksandr Mamlygo on 20.06.23.
//

struct Rocket {
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
    
    let height: Distance
    let diameter: Distance
    let mass: Mass
    
    init(rocketData: [String: Any]) {
        name = rocketData["name"] as? String ?? "Unknown"
        type = rocketData["type"] as? String ?? "Unknown"
        active = rocketData["active"] as? Bool ?? false
        stages = rocketData["stages"] as? Int ?? 0
        boosters = rocketData["boosters"] as? Int ?? 0
        costPerLaunch = rocketData["cost_per_launch"] as? Int ?? 0
        successRatePct = rocketData["success_rate_pct"] as? Int ?? 0
        firstFlight = rocketData["first_flight"] as? String ?? "Unknown"
        country = rocketData["country"] as? String ?? "Unknown"
        company = rocketData["company"] as? String ?? "Unknown"
        wikipedia = rocketData["wikipedia"] as? String ?? ""
        description = rocketData["description"] as? String ?? ""
        id = rocketData["id"] as? String ?? ""
        flickrImages = rocketData["flickr_images"] as? [String] ?? []
        
        height = Distance.getDistance(from: rocketData["height"] ?? "")
        diameter = Distance.getDistance(from: rocketData["diameter"] ?? "")
        mass = Mass.getMass(from: rocketData["mass"] ?? "")
    }
    
    static func getRockets(from value: Any) -> [Rocket] {
        guard let rocketData = value as? [[String: Any]] else { return [] }
        return rocketData.map { Rocket(rocketData: $0) }
    }
}

struct Distance {
    let meters: Double
    let feet: Double
    
    static func getDistance(from value: Any) -> Distance {
        guard let distanceData = value as? [String: Double] else { return Distance(meters: 0, feet: 0)}
        return Distance(meters: distanceData["meters"] ?? 0, feet: distanceData["feet"] ?? 0)
    }
}

struct Mass {
    let kg: Int
    let lb: Int
    
    static func getMass(from value: Any) -> Mass {
        guard let massData = value as? [String: Int] else { return Mass(kg: 0, lb: 0)}
        return Mass(kg: massData["kg"] ?? 0, lb: massData["lb"] ?? 0)
    }
}

