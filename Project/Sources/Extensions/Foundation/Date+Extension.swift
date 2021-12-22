//
//  Date+Extension.swift
//  BooksKeeper
//
//  Created by Viktoriya on 20.12.2021.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    func stripTime() -> Date {
         let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
         let date = Calendar.current.date(from: components)
         return date!
     }
}
