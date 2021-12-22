//
//  BooksListFabric.swift
//  BooksKeeper
//
//  Created by Viktoriya on 19.12.2021.
//

import UIKit

class BooksListFabric: ModelTableFabric {
    
// MARK: - Properties
    private weak var view: BooksListViewController?
    
    init(tableView: UITableView, view: BooksListViewController) {
        super.init(tableView: tableView)
        
        self.view = view
    }
    
    override func registerCells() {
        let bookNib = UINib(nibName: String(describing: BookCell.self.classForCoder()),
                            bundle: Bundle(for: BookCell.self))
        self.tableView?.register(bookNib,
                                 forCellReuseIdentifier: String(describing: BookCell.self.classForCoder()))
    }
    
    override func cell(forModelRow modelRow: ModelRow,
                       atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let tableView = self.tableView else { return UITableViewCell() }
        
        if let model = modelRow as? BookModelRow,
           let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookCell.self.classForCoder()),
                                                    for: indexPath) as? BookCell {
            
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = model.experationDate?.getFormattedDate(format: "dd.MM.yy")
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            cell.detailTextLabel?.textColor =  model.isExpired ? .red : .gray
           
            return cell
        }
        
        return UITableViewCell()
    }
}
