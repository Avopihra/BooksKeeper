//
//  Book.swift
//  BooksKeeper
//
//  Created by Viktoriya Gagarina on 18.12.2021.
//

import Foundation

// MARK: - Book Struct
/// Book entitiy with id, name, date
struct Book: Codable {
    
    private(set) var id: String!
    private(set) var name: String!
    private(set) var experationDate: Date!
    
    init?(id: String?,
          name: String?,
          experationDate: Date?) {
        guard let id = id,
              let name = name,
              let experationDate = experationDate else { return nil }
        
        // MARK: id
        self.id = id
        self.experationDate = experationDate
        self.name = name
    }
    
    mutating func setName(name: String) {
        self.name = name
    }
    
    mutating func setexperationDate(experationDate: Date) {
        self.experationDate = experationDate
    }
    
    var isExpired: Bool {
        let timeInSeconds = Date().timeIntervalSince(self.experationDate)
        if timeInSeconds > (60*60*24) {
            return true
        }
        return false
    }
}
