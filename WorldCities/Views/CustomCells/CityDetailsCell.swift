//
//  CityDetailsCell.swift
//  WorldCities
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell, BaseTableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    func configure<T>(_ infoModel: T) {
        let cityInfoModel = infoModel as! City
        self.cityLabel.text = cityInfoModel.cityName
        self.locationLabel.text = cityInfoModel.coord.cityLocation
    }
}
