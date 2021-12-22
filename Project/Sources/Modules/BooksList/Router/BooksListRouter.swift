//
//  BooksListRouter.swift
//  BooksKeeper
//
//  Created by Viktoriya on 19.12.2021.
//

import UIKit

enum SortingType {
    
    case sortByName
    case sortByDate
}

// MARK: - BooksListRouter
protocol BooksListRouter: BaseRouter {

    func showBookPage(isEditMode: Bool,
                      book: Book?,
                      completion: ((Book) -> Void)?)
    
    func showAlert(completion: ((SortingType) -> Void)?)
}

// MARK: - BooksListRouterImpl
class BooksListRouterImpl: BaseRouterImpl {

    private weak var view: BooksListViewController?

// MARK: - Init
    required init(view: BooksListViewController) {
        self.view = view
    }
}

// MARK: - BooksListRouter
extension BooksListRouterImpl: BooksListRouter {
    
    func showBookPage(isEditMode: Bool, book: Book?, completion: ((Book) -> Void)?) {
        guard let controller = BookPageViewController.create() as? BookPageViewController else { return }
        
        controller.configurator?.setCompletionValue(isEditMode: isEditMode,
                                                    book: book,
                                                    completion: { book in
                                                        completion?(book)
                                                    })
        
        self.view?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showAlert(completion: ((SortingType) -> Void)?) {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Sort by name", comment: ""),
                                      style: .default,
                                      handler: { ( _) in
                                        completion?(.sortByName)
                                      }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Sort by date", comment: ""),
                                      style: .default,
                                      handler: { ( _) in
                                        completion?(.sortByDate)
                                      }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""),
                                      style: .cancel,
                                      handler: nil))
        
        self.view?.present(alert, animated: true)
    }
}
