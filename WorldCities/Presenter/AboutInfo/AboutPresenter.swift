//
//  AboutPresenter.swift
//  WorldCities
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

class AboutPresenter: BaseListViewPresnter {
    
    override init(view: BaseViewProtocol?, model: BaseListModelProtocol?) {
        super.init(view: view, model: model)
        self.fetchAboutData()
    }
    
    func fetchAboutData() {
        view?.setActivityIndicator(hidden: false)
        
        if let model = self.model {
            model.fetchListInfo() { data, error in
                if data != nil {
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
}

