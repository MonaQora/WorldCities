//
//  TableViewDataSource.swift
//  WorldCities
//
//  Created by Mona Qora on 1/4/20.
//  Copyright © 2020 Mona Qora. All rights reserved.
//

import UIKit

class TableViewDataSource<CellType,DataModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
    
    let cellIdentifier: String
    let configureCell: (CellType, DataModel) -> ()
    let viewPresnter: BaseListViewPresnter
    
    init(cellIdentifier: String, viewPresnter: BaseListViewPresnter, configureCell: @escaping (CellType,DataModel) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.viewPresnter = viewPresnter
        self.configureCell = configureCell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewPresnter.numberOfRows(section: section)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CellType else {
            fatalError("Cell with identifier \(self.cellIdentifier) not found")
        }
        
        let dataModel = self.viewPresnter.modelAt(index: indexPath.row)! as DataModel
        self.configureCell(cell, dataModel)
        return cell
        
    }
    
}
