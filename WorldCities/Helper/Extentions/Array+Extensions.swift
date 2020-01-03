//
//  Array+Extensions.swift
//  WorldCities
//
//  Created by Mona Qora on 1/3/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import Foundation

extension Array {
    func subArray(startIndex: Int, endIndex: Int) -> [Element] {
        if startIndex > self.count || endIndex > self.count  {
            return []
        }
        return Array(self[startIndex..<endIndex])
    }
}
