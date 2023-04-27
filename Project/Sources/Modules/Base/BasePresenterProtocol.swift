//
//  BasePresenter.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import UIKit

public protocol BasePresenterProtocol: AnyObject {
    
// MARK: - Life Cycle
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

// MARK: - BasePresenterImpl
class BasePresenterImpl: BasePresenterProtocol {

// MARK: - Life Cycle
    func viewDidLoad() {}

    func viewWillAppear() {}

    func viewDidAppear() {}

    func viewWillDisappear() {}

    func viewDidDisappear() {}
}
