//
//  LocationData.swift
//  Landmarks
//
//  Created by Michael Mackiney on 2/10/20.
//  Copyright © 2020 Michael Mackiney. All rights reserved.
//

import Foundation

struct LocationData: Codable {
    let region: [Double]
    let places: [Locations]
}

struct Locations: Codable {
    let name: String
    let description: String
    let lat: Double
    let long: Double
}
