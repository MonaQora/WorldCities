//
//  JsonMapper.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

struct ResourceList<T> {
    let fileName: String
    let parse: (Data) -> [T]?
}

struct ResourceModel<T> {
    let fileName: String
    let parse: (Data) -> T?
}

class JsonMapper {
    
    func featchData<T>(resource: ResourceList<T>, completion: @escaping ((Response<[T], ModelError>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let jsonPath = Bundle.main.path(forResource: resource.fileName, ofType: "json") {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe) {
                    if let list = resource.parse(data) {
                        completion(Response.success(list))
                    }
                    else {
                        completion(Response.failure(ModelError.failedParseData))
                    }
                }
                else {
                    completion(Response.failure(ModelError.failedLoadingList))
                }
            }
            else {
                completion(Response.failure(ModelError.wrongPath))
            }
        }
    }
    
    func featchData<T>(resource: ResourceModel<T>, completion: @escaping ((Response<T, ModelError>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let jsonPath = Bundle.main.path(forResource: resource.fileName, ofType: "json") {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe) {
                    if let model = resource.parse(data) {
                        completion(Response.success(model))
                    }
                    else {
                        completion(Response.failure(ModelError.failedParseData))
                    }
                }
                else {
                    completion(Response.failure(ModelError.failedLoadingList))
                }
            }
            else {
                completion(Response.failure(ModelError.wrongPath))
            }
        }
    }
}
