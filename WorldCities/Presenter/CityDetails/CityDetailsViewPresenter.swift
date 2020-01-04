//
//  CityDetailsViewPresenter.swift
//  WorldCities
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit
import MapKit

protocol CityDetailsViewPresenterProtocol {
    func cityPinCoordinateLoaded(_ coordinate: CLLocationCoordinate2D)
    func failedLoadCityPinCoordinate()
    func cityNameLoaded(_ cityName: String?)
}

class CityDetailsViewPresenter {
    private var cityDetailsModel: CityDetailsModel! //Model
    private var cityDetailsView: CitiyDetailsViewProtocol?
    private var cityModel:City!

    init(view: CitiyDetailsViewProtocol, model: CityDetailsModel?, city:City) {
        cityDetailsView = view
        cityDetailsModel = model
        cityModel = city
        loadCityLocation()
    }
    
    func loadCityLocation() {
        if let location = cityDetailsModel.loadCityLocationFrom(city: cityModel) {
            self.cityPinCoordinateLoaded(location)
        }
        else {
            self.failedLoadCityPinCoordinate()
        }
    }
    
    func getCityName() {
        let name = cityDetailsModel.loadCityName(city: cityModel)
        self.cityNameLoaded(name)
    }
}

extension CityDetailsViewPresenter: CityDetailsViewPresenterProtocol {
    
    func cityPinCoordinateLoaded(_ coordinate: CLLocationCoordinate2D) {
        cityDetailsView?.setCityMapData(coordinate: coordinate)
    }
    
    func failedLoadCityPinCoordinate() {
        let error = ModelError.wrongCityLocation
        cityDetailsView?.setupErrorHandling(error: error)
    }
    
    func cityNameLoaded(_ cityName: String?) {
        cityDetailsView?.setCityViewTitle(cityName)
    }
    
}

