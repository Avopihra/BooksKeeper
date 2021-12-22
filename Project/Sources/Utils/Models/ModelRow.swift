//
//  ModelRow.swift
//  BooksKeeper
//
//  Created by Viktoriya on 17.12.2021.
//

import UIKit

class ModelRow {
    
    public var id: String!
    
    init() {
        self.id = UUID().uuidString
    }
    
    required init(id: String) {
        self.id = id
    }
}
