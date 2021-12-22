//
//  ModelTableFabric.swift
//  BooksKeeper
//
//  Created by Viktoriya on 19.12.2021.
//

import UIKit

class ModelTableFabric {

    public weak var tableView: UITableView!
    
    public init(tableView: UITableView) {
        self.tableView = tableView
        self.registerCells()
    }
    
    public func registerCells() {
    }
    
    public func cell(forModelRow modelRow: ModelRow,
                     atIndexPath indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
