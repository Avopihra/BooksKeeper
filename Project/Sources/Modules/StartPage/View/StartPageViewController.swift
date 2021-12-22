//
//  StartPageViewController.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import UIKit

// MARK: - StartPageView
protocol StartPageView: BaseView {
    
// MARK: - Show
    func show(data: StartPageData)
    func show(data: StartPageData, animated: Bool)
}

class StartPageViewController: BaseViewController {
    
    private var presenter: StartPagePresenter?
    private(set) var configurator: StartPageConfigurator?
    
// MARK: - Outlets
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet private weak var bookImageView: UIImageView!
    @IBOutlet private weak var startButton: UIButton!
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
        self.configureStartButton()
        self.configureTitleImage()
        self.configureBookImageView()
    }
    
    @IBAction func onStartButtonClicked(_ sender: Any) {
        self.presenter?.onStartButtonClicked()
    }
    
    private func configureStartButton() {
        self.startButton.setTitle(NSLocalizedString("Start", comment: ""), for: .normal)
        self.startButton.layer.shadowColor = UIColor.black.cgColor
        self.startButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.startButton.layer.shadowOpacity = 0.25
        self.startButton.layer.masksToBounds = false
        self.startButton.alpha = 0
    }
    
    private func configureTitleImage() {
        self.titleImage.alpha = 0
    }
    
    private func configureBookImageView() {
        self.bookImageView.alpha = 0
    }
}

// MARK: - Setup
extension StartPageViewController {

    func setup(presenter: StartPagePresenter?,
               configurator: StartPageConfigurator?) {
        self.presenter = presenter
        self.configurator = configurator
    }
}

extension StartPageViewController: StartPageView {
    
    func show(data: StartPageData) {
        self.show(data: data, animated: true)
    }
    
    func show(data: StartPageData, animated: Bool) {
        if data.isShowStartElements {
            self.animatingDisplayItems()
        }
    }
    
    private func animatingDisplayItems() {
        self.bookImageView.fadeIn(1, delay: 0.2) { _ in
            self.titleImage.fadeIn(1, delay: 0.2) { _ in
                self.startButton.fadeIn(0.4)
            }
        }
    }
}
