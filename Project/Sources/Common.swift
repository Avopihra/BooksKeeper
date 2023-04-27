//
//  Common.swift
//  BooksKeeper
//
//  Created by Viktoriya on 25.04.2023.
//

import Foundation

public func translate(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

public let isFirstLaunch = UserDefaults.isFirstLaunch()
public let loadingInterval = Int.random(in: 2...5)
public let appEnterInterval = 2.0
