//
//  CityDetailsModelTests.swift
//  WorldCitiesTests
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import XCTest
import MapKit
@testable import WorldCities

class CityDetailsModelTests: XCTestCase {

    private var model: CityDetailsModel?
    private var cityModel:City!
    private let timeOut = 30.0
    
    override func setUp() {
        model = CityDetailsModel()
        cityModel = City.init(country: "Egy", name: "Alexandria", coord: Location(lon: 20.0, lat: 21.0), identfier: 10)
    }

    override func tearDown() {
        model = nil
        cityModel = nil
    }

    func testLoadCityLocation() {
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(21.0, 20.0)
        let cityLocation = model?.loadCityLocationFrom(city: cityModel)
        XCTAssertNotNil(cityLocation)
        XCTAssertEqual(cityLocation?.latitude, location.latitude)
        XCTAssertEqual(cityLocation?.longitude, location.longitude)
    }
    
    func testLoadCityName() {
        let title = "Alexandria, Egy"
        let cityTitle = model?.loadCityName(city: cityModel)
        XCTAssertNotNil(cityTitle)
        XCTAssertEqual(cityTitle, title)
    }
    
}
