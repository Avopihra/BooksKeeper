//
//  UserDefaults+Extensions.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import Foundation

extension UserDefaults {
    
    private enum Constants {
        static let keyBooks = "books"
        static let keyLaunched = "hasBeenLaunched"
    }
    
    static func isFirstLaunch() -> Bool {
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: Constants.keyLaunched)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: Constants.keyLaunched)
        }
        return isFirstLaunch
    }
    
    static func writeBooksArray(books: [Book]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(books), forKey: Constants.keyBooks)
    }
    
    static func readBooksArray() -> [Book] {
        if let data = UserDefaults.standard.value(forKey: Constants.keyBooks) as? Data {
            let books = try? PropertyListDecoder().decode(Array<Book>.self, from: data)
            return books ?? []
        } else {
            return []
        }
    }
}
