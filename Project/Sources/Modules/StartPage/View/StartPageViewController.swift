//
//  StartPageViewController.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import UIKit
import Lottie


class StartPageViewController: BaseViewController {
    
    private var presenter: StartPagePresenterProtocol?
    private(set) var configurator: StartPageConfigurator?
    
// MARK: - Outlets
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet private weak var bookImageView: UIImageView?
    @IBOutlet private weak var startButton: UIButton?
    
    // MARK: - Properties
    private var loaderContainerView: LottieAnimationView? = LottieAnimationView()
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }
    
    @IBAction func onStartButtonClicked(_ sender: Any) {
        self.presenter?.onStartButtonClicked()
    }
    
    private func configureStartButton(inFirstLaunch: Bool) {
        self.startButton?.setTitle(NSLocalizedString("Start", comment: ""), for: .normal)
        self.startButton?.layer.shadowColor = UIColor.black.cgColor
        self.startButton?.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.startButton?.layer.shadowOpacity = 0.25
        self.startButton?.layer.masksToBounds = false
        self.startButton?.alpha = 0
    }
    
    private func configureLabels(inFirstLaunch: Bool) {
        self.titleLabel?.alpha = inFirstLaunch ? 0 : 1
        self.subtitleLabel?.alpha = inFirstLaunch ? 0 : 1
    }
    
    private func configureBookImageView(inFirstLaunch: Bool) {
        self.bookImageView?.alpha = inFirstLaunch ? 0 : 1
    }
    
    private func setupLoader() {
        self.loaderContainerView = .init(name: "loader")
        self.loaderContainerView?.backgroundColor = .clear
        self.loaderContainerView?.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        self.loaderContainerView?.center = self.view.center
        self.loaderContainerView?.contentMode = .scaleAspectFit
        self.loaderContainerView?.loopMode = .loop
        self.loaderContainerView?.animationSpeed = 0.5
        self.loaderContainerView?.alpha = 0
        self.view.addSubview(loaderContainerView ?? LottieAnimationView())
    }
}

// MARK: - Setup
extension StartPageViewController {

    func setup(presenter: StartPagePresenterProtocol?,
               configurator: StartPageConfigurator?) {
        self.presenter = presenter
        self.configurator = configurator
    }
}

extension StartPageViewController: StartPageViewProtocol {
    func hideLoader() {
        self.loaderContainerView?.stop()
        self.loaderContainerView?.fadeIn(0, delay: 0.2)
        self.loaderContainerView?.removeFromSuperview()
    }
    
    func showLoader() {
        self.setupLoader()
        self.loaderContainerView?.play()
        self.loaderContainerView?.fadeIn(1, delay: 0.2)
    }
    
    func showElements(inFirstLaunch: Bool) {
        self.configureStartButton(inFirstLaunch: inFirstLaunch)
        self.configureLabels(inFirstLaunch: inFirstLaunch)
        self.configureBookImageView(inFirstLaunch: inFirstLaunch)
        
        guard inFirstLaunch else {
            return
        }
        self.animatingDisplayItems()
    }
  
    private func animatingDisplayItems() {
        self.titleLabel?.fadeIn(1, delay: 0.2) { _ in
            self.subtitleLabel?.fadeIn(1, delay: 0.2) { _ in
                self.bookImageView?.fadeIn(1, delay: 0.2) { _ in
                    self.startButton?.fadeIn(1, delay: 0.2)
                }
            }
        }
    }
}
