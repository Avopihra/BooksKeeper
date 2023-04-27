//
//  Protocols.swift
//  BooksKeeper
//
//  Created by Viktoriya on 27.04.2023.
//

import Foundation

// MARK: - BooksListView
protocol BooksListViewProtocol: BaseViewProtocol {
    func show(data: BooksListData)
}

// MARK: - BooksListPresenter
protocol BooksListPresenterProtocol: BasePresenterProtocol {

// MARK: - Actions
    func onAddButtonClicked()
    func onSortingButtonClicked()
    func onBookClicked(_ bookId: String?)
    func deleteBook(_ bookId: String?)
}
