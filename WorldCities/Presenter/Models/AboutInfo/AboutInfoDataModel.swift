//
//  AboutDataModel.swift
//  WorldCities
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import Foundation

struct AboutInfoData: Codable {
    let companyName: String
    let companyAddress: String
    let postalCode: String
    let city: String
    let details: String
}
