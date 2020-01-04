//
//  AboutCell.swift
//  WorldCities
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell, BaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    func configure<T>(_ infoModel: T) {
        let aboutInfoData = infoModel as! AboutInfoUIData
        self.titleLabel.text = aboutInfoData.title
        self.detailsLabel.text = aboutInfoData.details
    }
}
