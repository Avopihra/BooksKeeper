//
//  GetBooksInteractor.swift
//  BooksKeeper
//
//  Created by Viktoriya on 19.12.2021.
//

import Foundation

protocol GetBooksListInteractor {
    
    func execute(completion: @escaping (_ books: [Book]) -> Void)
}

class GetBooksListInteractorImpl: GetBooksListInteractor {
    func execute(completion: @escaping ([Book]) -> Void) {
        let books = UserDefaults.readBooksArray()
        completion(books)
    }
}
