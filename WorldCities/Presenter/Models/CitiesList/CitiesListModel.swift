//
//  CitiesListModel.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

class CitiesListModel: BaseListModel {
    
    var fileName: String = "cities"
    private var resultsOffset: (start: Int, end: Int) = (start: 0, end: 0)
    private var citiesList: [City]?
    private var citiesListReversed : [City]?
    private var searchCitiesList: [City] {
        get {
            if let citiesList = self.citiesList {
                let resultList = citiesList.subArray(startIndex: resultsOffset.start, endIndex: resultsOffset.end)
                return resultList
            }
            return [City]()
        }
    }
    
    // Binary Search -- Complexity of search would be O(2 log n), using swift filter complexity would be O(n)
    // So using 2 binary searches one for get start index and one for get end index
    // time complexity better than using filter
    
    private func findStartIndex(searchValue: String) -> Int {
        let citiesList = self.citiesList!
        var startIndex = 0
        var endIndex = self.citiesList!.count
        var middleIndex = (startIndex + endIndex) / 2
        
        while startIndex != middleIndex {
            if searchValue <= citiesList[middleIndex].cityNameLowerCase {
                endIndex = middleIndex
            }
            else {
                startIndex = middleIndex
            }
            middleIndex = (startIndex + endIndex) / 2
        }
        
        return endIndex
    }
    
    private func findEndIndex(searchValue: String) -> Int {
        let citiesListReversed = self.citiesListReversed!
        var startIndex = 0
        var endIndex = citiesListReversed.count
        var middleIndex = (startIndex + endIndex) / 2
        
        while startIndex != middleIndex {
            if citiesListReversed[middleIndex].cityNameLowerCase.starts(with: searchValue) {
                endIndex = middleIndex
            }
            else {
                if searchValue > citiesListReversed[middleIndex].cityNameLowerCase {
                    endIndex = middleIndex
                }
                else {
                    startIndex = middleIndex
                }
            }
            middleIndex = (startIndex + endIndex) / 2
        }

        return citiesListReversed.count - endIndex
    }
    
   private func loadCitiesListFromFile(fileName: String, completion: @escaping ([City]?, ModelError?) -> Void) {
        self.jsonMapper = JsonMapper()
        let cityResource = ResourceList<City>(fileName: fileName) { data in
            var cityList:[City]?
            cityList = try? JSONDecoder().decode([City].self, from: data)
            return cityList
        }
        
        self.jsonMapper?.featchData(resource: cityResource) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let citiesList):
                    completion(citiesList, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    private func searchForCityInList(with cityName: String, completion:@escaping (_ startIndex: Int, _ endIndex: Int) -> Void) {
        var startIndex = 0
        var endIndex = self.citiesList!.count
        if !cityName.isEmpty {
            if (self.citiesList != nil) {
                startIndex = self.findStartIndex(searchValue: cityName.lowercased())
                endIndex = self.findEndIndex(searchValue: cityName.lowercased())
            }
        }
        completion (startIndex, endIndex)
    }
    
}

extension CitiesListModel: BaseListModelProtocol {
    func fetchListInfo(completion: @escaping ([AnyObject]?, ModelError?) -> Void) {
        self.loadCitiesListFromFile(fileName: fileName) {[weak self] citiesList, error in
            if let citites = citiesList {
                let sortedList = citites.sorted {
                    $0.cityNameLowerCase < $1.cityNameLowerCase
                }
                self?.citiesList = sortedList
                self?.citiesListReversed = sortedList.reversed()
                self?.resultsOffset = (start: 0, end: citites.count)
            }
            completion(citiesList as [AnyObject]?, error)
        }
    }
    
    func numberOfRowsAt(section: Int) -> Int {
        return searchCitiesList.count
    }
    
    func modelAt<T>(index: Int) -> T? {
        let cityItem = self.searchCitiesList[index]
        return cityItem as? T
    }
    
    func searchForCitiesContains(_ searchValue: String, completion: @escaping ([City]?) -> Void) {
        if citiesList != nil {
            self.searchForCityInList(with: searchValue) {[weak self] start, end in
                self?.resultsOffset = (start: start, end: end)
                completion (self?.searchCitiesList)
            }
        }
    }

}

