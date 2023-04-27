//
//  BaseTableViewController.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import UIKit

// MARK: - BaseTableViewController
class BaseTableViewController: BaseViewController {
    
    var fabric: ModelTableFabric!
    var modelSections = [ModelSection]()

    @IBOutlet weak var tableView: UITableView!

// MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
    }
    
// MARK: - Setup table view
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        if self.tableView.style == .plain {
            self.tableView.tableHeaderView = UIView(frame: .zero)
            self.tableView.tableFooterView = UIView(frame: .zero)
        }
        
        self.setupFabric()
    }
    
    func setupFabric() {
        assertionFailure("not init fabric")
    }
}

// MARK: - TableViewDataSource
extension BaseTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.modelSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.modelSections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.modelSections[indexPath.section]
        let row = section.rows[indexPath.row]
        return self.fabric.cell(forModelRow: row,
                                atIndexPath: indexPath)
    }

}

// MARK: - TableViewDelegate
extension BaseTableViewController: UITableViewDelegate {
    private func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
            return translate("Delete")
        }
}
