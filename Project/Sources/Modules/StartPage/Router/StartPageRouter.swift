//
//  StartPageRouter.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import UIKit

// MARK: - StartPageRouter
protocol StartPageRouter: BaseRouter {

    func showBooksList()
}

// MARK: - StartPageRouterImpl
class StartPageRouterImpl: BaseRouterImpl {

    private weak var view: StartPageViewController?

// MARK: - Init
    required init(view: StartPageViewController) {
        self.view = view
    }
}

// MARK: - StartPageRouter
extension StartPageRouterImpl: StartPageRouter {

    func showBooksList() {
        let controller = BooksListViewController.create()
        UIApplication.shared.windows.first?.rootViewController = controller
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
