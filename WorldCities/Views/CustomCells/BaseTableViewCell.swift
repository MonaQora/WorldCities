//
//  BaseTableViewCell.swift
//  WorldCities
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

protocol BaseTableViewCell {
    func configure<T> (_ infoModel: T)
}
