//
//  CitiesViewPresenter.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

import UIKit

class CitiesViewPresenter:BaseListViewPresnter {
    
    override init(view: BaseViewProtocol?, model: BaseListModelProtocol?) {
        super.init(view: view, model: model)
        self.fetchListCities()
    }
    
    func fetchListCities() {
        view?.setActivityIndicator(hidden: false)
        
        if let model = self.model {
            model.fetchListInfo() { listCities, error in
                if listCities != nil {
                    self.listDidLoad()
                }
                else {
                    self.listDidFailLoad(error: error!)
                }
            }
        }
        else {
            view?.setupErrorHandling(error: ModelError.failedLoadingList)
        }
    }
    
    override func numberOfRows(section: Int) -> Int? {
        return (model?.numberOfRowsAt(section: section))
    }
    
    override func modelAt<T>(index: Int) -> T? {
        return (model?.modelAt(index: index))
    }
    
    func searchForCitiesContains (_ searchValue: String) {
        model?.searchForCitiesContains(searchValue) { _ in
            self.listDidLoad()
        }
    }
}

