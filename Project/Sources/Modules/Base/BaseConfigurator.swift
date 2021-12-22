//
//  BaseConfigurator.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import Foundation

// MARK: - Configurator
public protocol BaseConfigurator where Self: NSObject {

// MARK: - Configuration
    func configure()
}

// MARK: - BaseConfiguratorImpl
class BaseConfiguratorImpl: NSObject, BaseConfigurator {

// MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        self.configure()
    }

// MARK: - Methods
    func configure() {
    }
}
