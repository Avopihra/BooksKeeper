//
//  BookPageRouter.swift
//  BooksKeeper
//
//  Created by Viktoriya on 19.12.2021.
//

import UIKit

// MARK: - BookPageRouter
protocol BookPageRouter: BaseRouter {

}

// MARK: - BookPageRouterImpl
class BookPageRouterImpl: BaseRouterImpl {

    private weak var view: BookPageViewController?

// MARK: - Init
    required init(view: BookPageViewController) {
        self.view = view
    }
}

// MARK: - BookPageRouter
extension BookPageRouterImpl: BookPageRouter {

}
