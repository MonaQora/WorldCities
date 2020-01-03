//
//  BasePresenter.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

protocol BaseListPresenterProtocol {
    func listDidLoad()
    func listDidFailLoad(error: ModelError)
}

extension BaseListViewPresnter: BaseListPresenterProtocol {
    func listDidLoad() {
        view?.setupViewData()
        view?.setActivityIndicator(hidden: true)
    }
    
    func listDidFailLoad(error: ModelError) {
        view?.setupErrorHandling(error: error)
        view?.setActivityIndicator(hidden: true)
    }
}

class BasePresenter {
    var view : BaseViewProtocol?
    var model: BaseListModelProtocol?

    public init(view: BaseViewProtocol?, model: BaseListModelProtocol?) {
        self.view = view
        self.model = model
    }
}

class BaseListViewPresnter: BasePresenter {
    func numberOfRows(section: Int) -> Int? {
        return 0
    }
    
    func modelAt<T>(index: Int) -> T? {
        return nil
    }
}


