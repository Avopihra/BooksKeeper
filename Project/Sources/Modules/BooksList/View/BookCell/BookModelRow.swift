//
//  BookModelRow.swift
//  BooksKeeper
//
//  Created by Viktoriya on 19.12.2021.
//

import Foundation

class BookModelRow: ModelRow {
    
    var name: String?
    var experationDate: Date?
    var isExpired = false
    
    convenience init(withBook book: Book) {
        self.init(id: book.id)
        
        self.name = book.name
        self.experationDate = book.experationDate
        self.isExpired = book.isExpired
    }
}
