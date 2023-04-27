//
//  ModelSection.swift
//  BooksKeeper
//
//  Created by Viktoriya on 17.12.2021.
//

import UIKit

class ModelSection {

    public var id: String = ""
    public var rows: [ModelRow] = []
        
    init(id: String = UUID().uuidString) {
        self.id = id
    }
}
