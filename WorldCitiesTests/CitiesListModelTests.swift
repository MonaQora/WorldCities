//
//  CitiesListModelTests.swift
//  WorldCitiesTests
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import XCTest
@testable import WorldCities

class CitiesListModelTests: XCTestCase {

    private var model: CitiesListModel?
    private var citiesList:[City]?
    private let timeOut = 30.0
    
    override func setUp() {
        model = CitiesListModel()
        model?.fileName = "citiesTest"
    }

    override func tearDown() {
        model = nil
    }
    
    func testLoadSucessData() {
        let expectation = XCTestExpectation(description: "Sucess load list")
        model?.fetchListInfo() {citiesList, error in
            expectation.fulfill()
            XCTAssertNotNil(citiesList)
            XCTAssertNil(error)
            XCTAssertEqual(citiesList!.count, 300)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeOut)
    }
    
    func testSearchForCititesStartsWithOCamelCase() {
        let expectation = XCTestExpectation(description: "Sucess load citites start with O")
        model?.fetchListInfo() {_, _ in
            self.model?.searchForCitiesContains("O") {searchCetiesList in
                XCTAssertEqual(searchCetiesList!.count, 3)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: timeOut)
    }
    
    func testSearchForCititesStartsWithOLowerCase() {
        let expectation = XCTestExpectation(description: "Sucess load citites start with o")
        model?.fetchListInfo() {_, _ in
            self.model?.searchForCitiesContains("o") {searchCetiesList in
                XCTAssertEqual(searchCetiesList!.count, 3)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: timeOut)
    }
    
    func testSearchForCititesStartsWithAL() {
        let expectation = XCTestExpectation(description: "Sucess load citites start with AL")
        model?.fetchListInfo() {_, _ in
            self.model?.searchForCitiesContains("Al") {searchCetiesList in
                XCTAssertEqual(searchCetiesList!.count, 13)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: timeOut)
    }
    
    func testSearchForCititesStartsWithALJ() {
        let expectation = XCTestExpectation(description: "Sucess load citites start with AL j")
        model?.fetchListInfo() {_, _ in
            self.model?.searchForCitiesContains("Al j") {searchCetiesList in
                XCTAssertEqual(searchCetiesList!.count, 2)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: timeOut)
    }
    
    func testNumberOfRows() {
        let expectation = XCTestExpectation(description: "Return correct number of rows")
        model?.fetchListInfo() {_, _ in
            XCTAssertEqual(self.model?.numberOfRowsAt(section: 1), 300)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeOut)
    }
    
    func testReturnCorrectModel() {
        let expectation = XCTestExpectation(description: "Return correct model")
        model?.fetchListInfo() {_, _ in
            let dataModel: City = (self.model?.modelAt(index: 10))!
            XCTAssertEqual(dataModel.identfier, 75508)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeOut)
    }
}
