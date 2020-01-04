//
//  CitiesListModel+SwiftFilterApproach.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

class CitiesListModelFilter:BaseListModel {
    
    var fileName: String = "cities"
    private var citiesList: [City]?
    private var searchCitiesList = [City]()
    
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
}

extension CitiesListModelFilter: BaseListModelProtocol {
    
    func fetchListInfo(completion: @escaping (AnyObject?, ModelError?) -> Void) {
        self.loadCitiesListFromFile(fileName: fileName) {[weak self] citiesList, error in
            if let citites = citiesList {
                let sortedList = citites.sorted {
                    $0.cityNameLowerCase < $1.cityNameLowerCase
                }
                self?.citiesList = sortedList
                self?.searchCitiesList = sortedList
            }
            completion(citiesList as AnyObject?, error)
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
        if !searchValue.isEmpty {
            searchCitiesList = citiesList!.filter {
                $0.cityNameLowerCase.starts(with: searchValue.lowercased())
            }
        }
        else {
            searchCitiesList = citiesList!
        }
        completion(searchCitiesList)
    }

}

