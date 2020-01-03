//
//  CitiesViewPresenterTests.swift
//  WorldCitiesTests
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import XCTest
@testable import WorldCities

class CitiesViewPresenterTests: XCTestCase {

    var presenter: CitiesViewPresenter!
    var view: CitiesListViewMock!
    var model : CitiesListModelMock!

    override func setUp() {
        model = CitiesListModelMock()
        view = CitiesListViewMock()
        initiatePresenter()
    }

    override func tearDown() {
        model = nil
        view = nil
        presenter = nil
    }

    func testPresenterLoadCitiesData() {
        presenter.fetchListCities()
        XCTAssertTrue(view.setupViewDataHasBeenCalled)
    }
    
    func testPresenterSetupErrorHandling() {
        model.returnData = false
        presenter.fetchListCities()
        XCTAssertTrue(view.setupErrorHandlingHasBeenCalled)
    }
    
    func testPresenterLoadCitiesDataNilModel() {
        model = nil
        initiatePresenter()
        presenter.fetchListCities()
        XCTAssertTrue(view.setupErrorHandlingHasBeenCalled)
    }
    
    private func initiatePresenter() {
        presenter = CitiesViewPresenter.init(view: view, model: model)
    }
}

class CitiesListModelMock: BaseListModel, BaseListModelProtocol {

    var returnData: Bool = true
    private var citiesList: [City]?
    
    func fetchListInfo(completion: @escaping ([AnyObject]?, ModelError?) -> Void) {
        if returnData {
            citiesList = [City.init(country: "Egypt", name: "Alexandria", coord: Location.init(lon: 20.0, lat: 20), identfier: 10),
                          City.init(country: "Egypt", name: "Cairo", coord: Location.init(lon: 21.0, lat: 20), identfier: 11)]
            completion(citiesList as [AnyObject]?, nil)
        }
        else {
            completion(nil, ModelError.failedLoadingList)
        }
    }
    
    func numberOfRowsAt(section: Int) -> Int {
        return citiesList?.count ?? 0
    }
    
    func modelAt<T>(index: Int) -> T? {
        let city = City.init(country: "Egypt", name: "Alexandria", coord: Location.init(lon: 20.0, lat: 20), identfier: 10)
        return city as? T
    }
}

class CitiesListViewMock: BaseViewProtocol {
    
    private(set) var setupViewDataHasBeenCalled: Bool = false
    private(set) var setupErrorHandlingHasBeenCalled: Bool = false
    
    func setupViewData() {
        setupViewDataHasBeenCalled = true
    }
    
    func setupErrorHandling(error: ModelError) {
        setupErrorHandlingHasBeenCalled = true
    }
}

