//
//  AboutModel.swift
//  WorldCities
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

class AboutListModel:BaseListModel {
    
    private var fileName: String = "aboutInfo"
    private typealias AboutInfoField = (name: String, keyPath: KeyPath<AboutInfoData, String>)
    private var aboutList: [AboutInfoField]?
    private var aboutInfo: AboutInfoData?
    private var aboutUIDataList = [AboutInfoUIData]()

    private let fields: [AboutInfoField] = [
        (name: "Name", keyPath: \AboutInfoData.companyName),
        (name: "Address", keyPath: \AboutInfoData.companyAddress),
        (name: "Postal Code", keyPath: \AboutInfoData.postalCode),
        (name: "City", keyPath: \AboutInfoData.city),
        (name: "Details", keyPath: \AboutInfoData.details),
        ]
    
    private func loadAboutInfofromFile(fileName: String, completion: @escaping (AboutInfoData?, ModelError?) -> Void) {
         self.jsonMapper = JsonMapper()
         let aboutResource = ResourceModel<AboutInfoData>(fileName: fileName) { data in
             var aboutData:AboutInfoData?
             aboutData = try? JSONDecoder().decode(AboutInfoData.self, from: data)
             return aboutData
         }
         self.jsonMapper?.featchData(resource: aboutResource) { result in
             DispatchQueue.main.async {
                switch result {
                case .success(let aboutData):
                    completion(aboutData , nil)
                case .failure(let error):
                    completion(nil, error)
                }
             }
         }
     }

}

extension AboutListModel: BaseListModelProtocol {
    func fetchListInfo(completion: @escaping (AnyObject?, ModelError?) -> Void) {
        self.loadAboutInfofromFile(fileName: fileName) {[weak self] aboutInfo, error in
            if let aboutInfo = aboutInfo {
                self?.aboutInfo = aboutInfo
                if let fields = self?.fields {
                    for field in fields {
                        let dataInfo = AboutInfoUIData.init(title: field.name, details: aboutInfo[keyPath: field.keyPath])
                        self?.aboutUIDataList.append(dataInfo)
                    }
                }
            }
            completion(aboutInfo as AnyObject?, error)
        }
    }
    
    func numberOfRowsAt(section: Int) -> Int {
        return aboutUIDataList.count
    }
    
    func modelAt<T>(index: Int) -> T {
        let cellData = aboutUIDataList[index]
        return cellData as! T
    }
    
}

