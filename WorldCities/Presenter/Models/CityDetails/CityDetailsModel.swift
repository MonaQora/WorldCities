//
//  CityDetailsModel.swift
//  WorldCities
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit
import MapKit

class CityDetailsModel {
    
    func loadCityLocationFrom (city: City?) -> CLLocationCoordinate2D? {
        return city?.cityCoordinate
    }
    
    func loadCityName (city: City?) -> String? {
        return city?.cityName
    }
    
}
