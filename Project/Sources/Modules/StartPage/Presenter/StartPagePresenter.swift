//
//  StartPagePresenter.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import Foundation


// MARK: - StartPagePresenterImpl
class StartPagePresenterImpl: BasePresenterImpl {
    
    private weak var view: StartPageViewProtocol?
    private var router: StartPageRouter?
    
    // MARK: - Data
    private var data = StartPageData()
    
    // MARK: - Init
    required init(view: StartPageViewProtocol,
                  router: StartPageRouter) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.enterTheApp()
    }
}

// MARK: - StartPagePresenter
extension StartPagePresenterImpl: StartPagePresenterProtocol {
    
    private func enterTheApp() {
        guard isFirstLaunch else {
                self.view?.showElements()
                DispatchQueue.main.asyncAfter(deadline: .now() + appEnterInterval) {
                    self.onStartButtonClicked()
                }
            return
        }
        self.view?.showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(loadingInterval)) {
            self.view?.hideLoader()
            self.view?.showElements(inFirstLaunch: true)
        }
    }

    func onStartButtonClicked() {
        self.router?.showBooksList()
    }
}
