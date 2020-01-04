//
//  AboutModelTests.swift
//  WorldCitiesTests
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import XCTest
@testable import WorldCities

class AboutViewTests: XCTestCase {

    private var model: AboutListModel?
    private let timeOut = 10.0
    
    override func setUp() {
        model = AboutListModel()
    }

    override func tearDown() {
        model = nil
    }

    func testSucessLoadData() {
        let expectation = XCTestExpectation(description: "Sucess load list")
        model?.fetchListInfo() {aboutInfo, error in
            expectation.fulfill()
            XCTAssertNotNil(aboutInfo)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeOut)
    }

    func testNumberOfRows() {
        let expectation = XCTestExpectation(description: "Return correct number of rows")
        model?.fetchListInfo() {_, _ in
            XCTAssertEqual(self.model?.numberOfRowsAt(section: 1), 5)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeOut)
    }
    
    func testReturnCorrectModel() {
        let expectation = XCTestExpectation(description: "Return correct model")
        model?.fetchListInfo() {_, _ in
            let dataModel: AboutInfoUIData = (self.model?.modelAt(index: 1))!
            XCTAssertEqual(dataModel.title, "Address")
            XCTAssertEqual(dataModel.details, "Jacob Bontiusplaats 9")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeOut)
    }
}
