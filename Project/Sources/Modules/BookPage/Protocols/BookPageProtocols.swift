//
//  BookPageProtocols.swift
//  BooksKeeper
//
//  Created by Viktoriya on 27.04.2023.
//

import Foundation

// MARK: - BookPageView
protocol BookPageViewProtocol: BaseViewProtocol {
    
    func show(data: BookPageData)
}


// MARK: - BookPagePresenter
protocol BookPagePresenterProtocol: BasePresenterProtocol {
    
    func setCompletionValue(isEditMode: Bool,
                            book: Book?,
                            completion: ((Book) -> Void)?)
    
    func onBookPageActionButtonClicked(pickedDate: Date,
                               writedName: String)
}
