//
//  BooksListConfigurator.swift
//  BooksKeeper
//
//  Created by Viktoriya on 19.12.2021.
//

import UIKit

// MARK: - Configurator
protocol BooksListConfigurator: BaseConfigurator {

}

// MARK: - BooksListConfiguratorImpl
class BooksListConfiguratorImpl: BaseConfiguratorImpl {

    private weak var presenter: BooksListPresenterProtocol?

// MARK: - Outlets
    @IBOutlet private weak var viewController: BooksListViewController!
    
// MARK: - Configure
    override func configure() {
        let router = BooksListRouterImpl(view: self.viewController)
        let interactors = BooksListInteractors(getBooksListInteractor: GetBooksListInteractorImpl(),
                                               saveBooksListInteractor: SaveBooksListInteractorImpl())
        let presenter = BooksListPresenterImpl(view: self.viewController,
                                               router: router,
                                               interactors: interactors)
        self.presenter = presenter

        self.viewController.setup(presenter: self.presenter, configurator: self)
    }
}

extension BooksListConfiguratorImpl: BooksListConfigurator {

}
