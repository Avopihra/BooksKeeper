//
//  SaveBooksListInteractor.swift
//  BooksKeeper
//
//  Created by Viktoriya on 19.12.2021.
//

import Foundation

protocol SaveBooksListInteractor {
    
    func execute(books: [Book],
                 completion: @escaping () -> Void)
}

class SaveBooksListInteractorImpl: SaveBooksListInteractor {
    
    func execute(books: [Book],
                 completion: @escaping () -> Void) {
        UserDefaults.writeBooksArray(books: books)
        completion()
    }
}
