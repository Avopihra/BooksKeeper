//
//  BasePresenter.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import UIKit

public protocol BasePresenter: AnyObject {
    
// MARK: - Life Cycle
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

// MARK: - BasePresenterImpl
class BasePresenterImpl: BasePresenter {

// MARK: - Life Cycle
    func viewDidLoad() {}

    func viewWillAppear() {}

    func viewDidAppear() {}

    func viewWillDisappear() {}

    func viewDidDisappear() {}
}
