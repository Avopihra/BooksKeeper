//
//  BaseViewController.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import UIKit

protocol BaseViewProtocol: UIViewController {

}

// MARK: - Base View Controller
class BaseViewController: UIViewController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationPreference()
    }

    // MARK: - Navigation bar
    private func setupNavigationPreference() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
    }
}

