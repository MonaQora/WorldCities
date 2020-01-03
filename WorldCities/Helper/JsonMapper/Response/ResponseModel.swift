//
//  ResponseModel.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import Foundation

enum Response<T, E: Error> {
    case success(T)
    case failure(E)
}

enum ModelError: Error {
    case wrongPath
    case failedLoadingList
    case failedParseData
}

extension ModelError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .wrongPath: return ErrorDescreption.wrongJsonPath
        case .failedLoadingList: return ErrorDescreption.failedLoadList
        case .failedParseData: return ErrorDescreption.failedParseData
        }
    }
}

