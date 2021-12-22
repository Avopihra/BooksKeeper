//
//  StartPageConfigurator.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import UIKit

// MARK: - Configurator
protocol StartPageConfigurator: BaseConfigurator {

}

// MARK: - StartPageConfiguratorImpl
class StartPageConfiguratorImpl: BaseConfiguratorImpl {

    private weak var presenter: StartPagePresenter?

// MARK: - Outlets
    @IBOutlet private weak var viewController: StartPageViewController!
    
// MARK: - Configure
    override func configure() {
        let router = StartPageRouterImpl(view: self.viewController)

        let presenter = StartPagePresenterImpl(view: self.viewController, router: router)
        self.presenter = presenter

        self.viewController.setup(presenter: self.presenter, configurator: self)
    }
}

extension StartPageConfiguratorImpl: StartPageConfigurator {

}
