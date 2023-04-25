//
//  BaseViewController.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import UIKit

protocol BaseViewControllerProtocol: UIViewController {
    
    // MARK: - Loading indicator
    func setLoadingVisible(_ visible: Bool)
}

// MARK: - Base View Controller
class BaseViewController: UIViewController {
    
    let baseLoaderContainer = UIView(frame: CGRect(x: .zero, y: .zero, width: 100, height: 100))
    let baseLoaderView = UIImageView(image: UIImage(named: "loaderIcon"))
    let spinner = AnimationSpinner(withDimension: 100.0)
    let innerLayerSpinner = AnimationSpinner(withDimension: 100.0)
    let innerLayer = CAShapeLayer()
    let innerCircle = CAShapeLayer()
    let outerCircle = CAShapeLayer()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationPreference()
    }

    // MARK: - Navigation bar
    func setupNavigationPreference() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
    }
}

extension BaseViewController: BaseViewControllerProtocol {
    func setLoadingVisible(_ visible: Bool) {
        
        if visible {
            DispatchQueue.main.async {
                
                let midViewX = self.view.frame.midX
                let midViewY = self.view.frame.midY
                
                //MARK: - innerCircle configure
                let innerCirclePath = UIBezierPath(arcCenter: CGPoint(x: midViewX,y: midViewY), radius: CGFloat(34), startAngle: CGFloat(0), endAngle:CGFloat(CGFloat.pi * 2), clockwise: true)
                
                self.innerCircle.path = innerCirclePath.cgPath
                self.innerCircle.fillColor = UIColor.clear.cgColor
                self.innerCircle.strokeColor = UIColor(named: "circleBlue")!.cgColor
                self.innerCircle.lineWidth = 1.0
                self.view.layer.addSublayer(self.innerCircle)
                
                //MARK: - outerCircle configure
                let outerCirclePath = UIBezierPath(arcCenter: CGPoint(x: midViewX,y: midViewY), radius: CGFloat(50), startAngle: CGFloat(0), endAngle:CGFloat(CGFloat.pi * 2), clockwise: true)
                
                self.outerCircle.path = outerCirclePath.cgPath
                self.outerCircle.fillColor = UIColor.clear.cgColor
                self.outerCircle.strokeColor = UIColor(named: "circleBlue")!.cgColor
                self.outerCircle.lineWidth = 1.0
                self.view.layer.addSublayer(self.outerCircle)
                
                //MARK: - innerLayer without color animation configure
                
                let circlePath = UIBezierPath(arcCenter: CGPoint(x: midViewX,y: midViewY), radius: CGFloat(42), startAngle: CGFloat(0), endAngle:CGFloat(CGFloat.pi * 2), clockwise: true)
                
                self.innerLayer.path = circlePath.cgPath
                self.innerLayer.fillColor = UIColor.clear.cgColor
                self.innerLayer.strokeColor = UIColor(named: "loaderColor")!.cgColor
                self.innerLayer.lineWidth = 15.0
                //                self.view.layer.addSublayer(self.innerLayer) // Вариант для отображения классического индикатора загрузки без анимации
                
                //MARK: - innerLayer with color animation configure
                
                self.innerLayerSpinner.frame = CGRect(x: self.view.bounds.midX - self.innerLayerSpinner.dimension/2,
                                                      y: self.view.bounds.midY - self.innerLayerSpinner.dimension/2,
                                                      width: self.innerLayerSpinner.dimension,
                                                      height: self.innerLayerSpinner.dimension)
                self.innerLayerSpinner.trailColors = [UIColor(named: "loaderColor")!,
                                                      UIColor(named: "loaderColor-1")!,
                                                      UIColor(named: "loaderColor-2")!,
                                                      UIColor(named: "loaderColor-3")!]
                self.innerLayerSpinner.shouldShowSpinner = false
                self.innerLayerSpinner.thickness = 15.0
                self.innerLayerSpinner.duration = 1.0
                self.innerLayerSpinner.setup()
                self.innerLayerSpinner.startAnimating()
                self.view.addSubview(self.innerLayerSpinner) //Закомментировать для отображения классического индикатора загрузки без анимации
                
                //MARK: - spinner configure
                self.spinner.frame = CGRect(x: self.view.bounds.midX - self.spinner.dimension/2,
                                            y: self.view.bounds.midY - self.spinner.dimension/2,
                                            width: self.spinner.dimension,
                                            height: self.spinner.dimension)
                
                self.spinner.thickness = 12.0
                self.spinner.shouldAnimateColorChange = false
                self.spinner.shouldShowTrailColors = false
                self.spinner.duration = 1.0
                self.spinner.circleColor = UIColor.clear
                self.spinner.setup()
                self.spinner.startAnimating()
                self.view.addSubview(self.spinner)
            }
        } else {
            DispatchQueue.main.async {
                self.spinner.stopRotating()
                self.spinner.removeFromSuperview()
                self.innerLayerSpinner.removeFromSuperview()
                self.innerLayer.removeFromSuperlayer()
                self.innerCircle.removeFromSuperlayer()
                self.outerCircle.removeFromSuperlayer()
            }
        }
    }
}
