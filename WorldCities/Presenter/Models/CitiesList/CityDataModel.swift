//
//  CityDataModel.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit
import MapKit

struct City: Codable {
    let country: String
    let name: String
    let coord: Location
    let identfier: Int

    var cityName: String {
        get {
            return "\(name), \(country)"
        }
    }
    
    var cityNameLowerCase: String {
        get {
            return cityName.lowercased()
        }
    }
    
    var cityCoordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(coord.lat, coord.lon)
        }
    }
    
    private enum CodingKeys: String, CodingKey { case country, name, coord
        case identfier = "_id"
    }
}

struct Location: Codable {
    
    let lon: Double
    let lat: Double
    
    var cityLocation: String {
        return "lat: \(lat), long: \(lon)"
    }
    
}

