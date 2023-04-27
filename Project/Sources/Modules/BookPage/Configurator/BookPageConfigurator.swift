//
//  BookPageConfigurator.swift
//  BooksKeeper
//
//  Created by Viktoriya on 19.12.2021.
//

import UIKit

// MARK: - Configurator
protocol BookPageConfigurator: BaseConfigurator {

    func setCompletionValue(isEditMode: Bool,
                            book: Book?,
                            completion: ((Book) -> Void)?)
}

// MARK: - BookPageConfiguratorImpl
class BookPageConfiguratorImpl: BaseConfiguratorImpl {

    private weak var presenter: BookPagePresenterProtocol?

// MARK: - Outlets
    @IBOutlet private weak var viewController: BookPageViewController!
    
// MARK: - Configure
    override func configure() {
        let router = BookPageRouterImpl(view: self.viewController)

        let presenter = BookPagePresenterImpl(view: self.viewController, router: router)
        self.presenter = presenter

        self.viewController.setup(presenter: self.presenter, configurator: self)
    }
}

extension BookPageConfiguratorImpl: BookPageConfigurator {
    
    func setCompletionValue(isEditMode: Bool,
                            book: Book?,
                            completion: ((Book) -> Void)?) {
        
        self.presenter?.setCompletionValue(isEditMode: isEditMode,
                                           book: book,
                                           completion: completion)
    }
}
