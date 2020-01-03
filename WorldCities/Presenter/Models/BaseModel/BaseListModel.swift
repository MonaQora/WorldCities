//
//  BaseModel.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

protocol BaseListModelProtocol {
    func fetchListInfo(completion: @escaping ([AnyObject]?, ModelError?) -> Void)
    func numberOfRowsAt(section: Int) -> Int
    func modelAt<T>(index: Int) -> T?
}

class BaseListModel {
    var jsonHandler: JsonMapper?
}

