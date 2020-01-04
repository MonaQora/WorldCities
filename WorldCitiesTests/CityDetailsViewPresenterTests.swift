//
//  CityDetailsViewPresenterTests.swift
//  WorldCitiesTests
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import XCTest
import MapKit
@testable import WorldCities

class CityDetailsViewPresenterTests: XCTestCase {

    var presenter: CityDetailsViewPresenter!
    var view: CitiesDetailsViewMock!
    var model : CitiesDetailsModelMock!
    private var city:City!

    override func setUp() {
        model = CitiesDetailsModelMock()
        view = CitiesDetailsViewMock()
        city = City.init(country: "Egy", name: "Alexandria", coord: Location(lon: 20.0, lat: 21.0), identfier: 10)
        presenter = CityDetailsViewPresenter.init(view: view, model: model, city: city)
    }

    override func tearDown() {
        model = nil
        view = nil
        presenter = nil
    }

    func testSucessLoadCityLocation() {
        presenter.loadCityLocation()
        XCTAssertTrue(view.setCityMapDataHasBeenCalled)
    }
    
    func testFailedLoadCityLocation() {
        model.location = nil
        presenter.loadCityLocation()
        XCTAssertTrue(view.setupErrorHandlingHasBeenCalled)
    }
    
    func testSucessLoadCityName() {
        presenter.getCityName()
        XCTAssertTrue(view.setCityViewTitleHasBeenCalled)
    }

}

class CitiesDetailsModelMock: CityDetailsModel{
    
    var location:CLLocationCoordinate2D? = CLLocationCoordinate2DMake(20.0, 21)
    
    override func loadCityLocationFrom(city: City?) -> CLLocationCoordinate2D? {
        return location
    }
}

class CitiesDetailsViewMock: CitiyDetailsViewProtocol {
    
    private(set) var setCityMapDataHasBeenCalled: Bool = false
    private(set) var setCityViewTitleHasBeenCalled: Bool = false
    private(set) var setupErrorHandlingHasBeenCalled: Bool = false

    func setCityMapData(coordinate: CLLocationCoordinate2D) {
        setCityMapDataHasBeenCalled = true
    }
    
    func setupErrorHandling(error: ModelError) {
        setupErrorHandlingHasBeenCalled = true
    }
    
    func setCityViewTitle(_ name: String?) {
        setCityViewTitleHasBeenCalled = true
    }

}
