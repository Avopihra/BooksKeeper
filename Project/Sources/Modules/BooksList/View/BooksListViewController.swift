//
//  BooksListController.swift
//  BooksKeeper
//
//  Created by Viktoriya on 17.12.2021.
//

import UIKit

// MARK: - BooksListSection
private enum BooksListSection: Int {
    
    case notExpiredBooks
    case expiredBooks
    
    var id: String {
        return String(self.rawValue)
    }
}

// MARK: - BooksListView
protocol BooksListView: BaseView {
    
// MARK: - Show
    func show(data: BooksListData)
}

// MARK: - BooksListViewController
class BooksListViewController: BaseTableViewController {
    
// MARK: - VIPER
    var presenter: BooksListPresenter?
    var configurator: BooksListConfigurator?
    
// MARK: - Outlets
    @IBOutlet private weak var emptyListView: UILabel!
    @IBOutlet weak var bookListItem: UINavigationItem!
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavBar()
        self.presenter?.viewDidLoad()
        
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor.gray
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
// MARK: - Fabric
    override func setupFabric() {
        self.fabric = BooksListFabric(tableView: self.tableView, view: self)
    }

    private func configureNavBar() {
        self.bookListItem.title = NSLocalizedString("Books list", comment: "")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonClicked))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "shapeIcon"), style: .done, target: self, action: #selector(onSortingButtonClicked))
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "backgroundGray")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        self.navigationController?.navigationBar.tintColor = UIColor(named: "blueButton")
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func onAddButtonClicked(sender: UIBarButtonItem) {
        self.presenter?.onAddButtonClicked()
    }
    
    @objc func onSortingButtonClicked(sender: UIBarButtonItem) {
        self.presenter?.onSortingButtonClicked()
    }
}

// MARK: - Setup
extension BooksListViewController {

    func setup(presenter: BooksListPresenter?,
               configurator: BooksListConfigurator?) {
        self.presenter = presenter
        self.configurator = configurator
    }
}

extension BooksListViewController: BooksListView {

    func show(data: BooksListData) {
        self.modelSections.removeAll()
        let notExpiratedBooks = data.books.filter({!$0.isExpired})
        let expiratedBooks = data.books.filter({$0.isExpired})
        
        self.emptyListView.text = NSLocalizedString("Empty list", comment: "")
        self.emptyListView.isHidden = !data.books.isEmpty
        if !notExpiratedBooks.isEmpty {

            self.modelSections.append(self.createNotExpiratedSection(notExpiratedBooks))
        }
        if !expiratedBooks.isEmpty {
            
            self.modelSections.append(self.createExpiratedSection(expiratedBooks))
        }
    
        self.setLeftButtonMode(visible: data.books.count > 1)
        
        self.tableView.reloadData()
    }
    
    private func setLeftButtonMode(visible: Bool) {
        self.navigationItem.leftBarButtonItem?.isEnabled = visible
        self.navigationItem.leftBarButtonItem?.tintColor = visible ?  UIColor.systemBlue : UIColor.clear
    }
    
    private func createNotExpiratedSection(_ books: [Book]) -> ModelSection {
        let section = ModelSection(id: BooksListSection.notExpiredBooks.id)
        var rows = [ModelRow]()
        
        for book in books {
            let bookModel = BookModelRow(withBook: book)
            rows.append(bookModel)
        }
        
        section.rows = rows
        return section
    }
    
    private func createExpiratedSection(_ books: [Book]) -> ModelSection {
        let section = ModelSection(id: BooksListSection.expiredBooks.id)
        var rows = [ModelRow]()
        
        for book in books {
            let bookModel = BookModelRow(withBook: book)
            rows.append(bookModel)
        }
        
        section.rows = rows
        return section
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let model = self.modelSections[indexPath.section].rows[indexPath.row] as? BookModelRow {
            self.presenter?.onBookClicked(model.id)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if let model = self.modelSections[indexPath.section].rows[indexPath.row] as? BookModelRow {
                self.presenter?.deleteBook(model.id)

            }
        }
    }
}

