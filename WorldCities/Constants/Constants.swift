//
//  Constants.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import Foundation
import MapKit

struct Map {
    static let zoom: CLLocationDegrees = 10.0
}

struct ViewTitles {
    static let cititlsListViewTitle = "Cities"
    static let cityDetailsViewTitle = "City Details"
}

struct ErrorDescreption {
    static let defaultErrorMessage = "Somthing went wrong."
    static let wrongJsonPath = "Wrong json path."
    static let failedLoadList = "Failed to load list."
    static let failedParseData = "Failed parse data."
    static let failedLoadCityCoordinate = "Somthing went wrong, Failed load city location."
}

