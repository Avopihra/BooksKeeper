//
//  StartPagePresenter.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import Foundation

// MARK: - StartPagePresenter
protocol StartPagePresenter: BasePresenter {

    func onStartButtonClicked()
}

// MARK: - StartPagePresenterImpl
class StartPagePresenterImpl: BasePresenterImpl {

    private weak var view: StartPageView?
    private var router: StartPageRouter?

// MARK: - Data
    private var data = StartPageData()
    
// MARK: - Init
    required init(view: StartPageView,
                  router: StartPageRouter) {
        self.view = view
        self.router = router
    }

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startTimer()
    }
}

// MARK: - StartPagePresenter
extension StartPagePresenterImpl: StartPagePresenter {
    
    private func startTimer() {
        self.data.isShowStartElements = false
        self.view?.setLoadingVisible(true)
        
        self.view?.show(data: self.data)
        let randomTime = Int.random(in: 2...5)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(randomTime)) {
                self.view?.setLoadingVisible(false)
                
                if UserDefaults.isFirstLaunch() {
                    self.data.isShowStartElements = true
                    self.view?.show(data: self.data)
                    return
                }
                self.router?.showBooksList()
        }
    }
    
    func onStartButtonClicked() {
        self.router?.showBooksList()
    }

}
