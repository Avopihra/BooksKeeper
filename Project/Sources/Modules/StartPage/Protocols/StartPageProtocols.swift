//
//  StartPageProtocols.swift
//  BooksKeeper
//
//  Created by Viktoriya on 26.04.2023.
//

import Foundation

// MARK: - StartPageView
protocol StartPageViewProtocol: BaseViewProtocol {
    func showLoader()
    func hideLoader()
    func showElements(inFirstLaunch: Bool)
}

// MARK: - StartPagePresenter
protocol StartPagePresenterProtocol: BasePresenterProtocol {
    func onStartButtonClicked()
}

//MARK: - Extensions
extension StartPageViewProtocol {
    func showElements(inFirstLaunch: Bool = false) {
        return showElements(inFirstLaunch: inFirstLaunch)
    }
}
