//
//  UIViewController+Extension.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import UIKit

extension UIViewController {
    
    static func create() -> UIViewController {
        let viewController = UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController() ?? UIViewController()
        return viewController
    }

}
