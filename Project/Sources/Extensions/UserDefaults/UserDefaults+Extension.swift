//
//  UserDefaults+Extensions.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import Foundation

extension UserDefaults {
    
    static let keyBooks = "books"
    static let keyLaunched = "hasBeenLaunched"

    static func isFirstLaunch() -> Bool {
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: keyLaunched)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: keyLaunched)
        }
        return isFirstLaunch
    }
    
    static func writeBooksArray(books: [Book]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(books), forKey: keyBooks)
    }
    
    static func readBooksArray() -> [Book] {
        if let data = UserDefaults.standard.value(forKey: keyBooks) as? Data {
            let books = try? PropertyListDecoder().decode(Array<Book>.self, from: data)
            return books ?? []
        } else {
            return []
        }
    }
}
