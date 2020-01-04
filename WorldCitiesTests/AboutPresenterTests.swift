//
//  AboutPresenterTests.swift
//  WorldCitiesTests
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import XCTest
@testable import WorldCities

class AboutPresenterTests: XCTestCase {
    var presenter: AboutPresenter!
    var view: CitiesListViewMock!
    var model : CitiesListModelMock!
    
    override func setUp() {
        model = CitiesListModelMock()
        view = CitiesListViewMock()
        presenter = AboutPresenter.init(view: view, model: model)
    }
    
    override func tearDown() {
        model = nil
        view = nil
        presenter = nil
    }
    
    func testPresenterLoadAboutData() {
        presenter.fetchAboutData()
        XCTAssertTrue(view.setupViewDataHasBeenCalled)
    }
    
    func testPresenterSetupErrorHandling() {
        model.returnData = false
        presenter.fetchAboutData()
        XCTAssertTrue(view.setupErrorHandlingHasBeenCalled)
    }
    
    func testPresenterLoadCitiesDataNilModel() {
        model = nil
        presenter = AboutPresenter.init(view: view, model: model)
        presenter.fetchAboutData()
        XCTAssertTrue(view.setupErrorHandlingHasBeenCalled)
    }
}

class AboutModelMock: BaseListModel, BaseListModelProtocol {
    
    var returnData: Bool = true
    var aboutInfoData: AboutInfoData?
    
    func fetchListInfo(completion: @escaping (AnyObject?, ModelError?) -> Void) {
        if returnData {
            aboutInfoData = AboutInfoData.init(companyName: "Vodafone", companyAddress: "Technology park, Maadi.", postalCode: "0701", city: "Cairo", details: "This is About info tests.")
        }
        else {
            completion(nil, ModelError.failedLoadingList)
        }
    }
    
    func numberOfRowsAt(section: Int) -> Int {
        if aboutInfoData != nil {
            return 5
        }
        else {
            return 0
        }
    }
    
    func modelAt<T>(index: Int) -> T? {
        return aboutInfoData as? T
    }
}

class AboutViewMock: BaseViewProtocol {
    
    private(set) var setupViewDataHasBeenCalled: Bool = false
    private(set) var setupErrorHandlingHasBeenCalled: Bool = false
    
    func setupViewData() {
        setupViewDataHasBeenCalled = true
    }
    
    func setupErrorHandling(error: ModelError) {
        setupErrorHandlingHasBeenCalled = true
    }
    
}



