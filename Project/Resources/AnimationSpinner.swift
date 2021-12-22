//
//  AnimationSpinner
//  BooksKeeper
//
//  Created by Viktoriya on 21.12.2021.
//

import UIKit

class AnimationSpinner: UIView {

    // MARK: - Properties
    private var path: UIBezierPath!
    
    private var circleLayer: CAShapeLayer!
    
    private var trailLayer1: CAShapeLayer!
    
    private var trailLayer2: CAShapeLayer!
    
    private var spinnerLayer: CAShapeLayer!
    
    private var isAnimatingFirstTrailLayer = true
    
    private var trail1Animation: CABasicAnimation!
    
    private var trail2Animation: CABasicAnimation!
    
    private var spinnerAnimation: CAKeyframeAnimation!
    
    private var currentColorIndex: Int = 0
    
    
    var dimension: CGFloat!
    
    var clockwiseDirection = true
    
    var trailColors = [UIColor(named: "loaderColor")!, UIColor(named: "loaderColor-1")!]
    
    var thickness: CGFloat = 3.0
    
    var duration: Double = 1.0
    
    var circleColor = UIColor.clear
    
    var spinnerColor = UIColor.black
    
    var shouldShowTrailColors = true
    
    var shouldAnimateColorChange = true
    
    var shouldShowSpinner = true
    
    var shouldUpdateSpinnerColor = true
    
// MARK: - Initialization

    init(withDimension dimension: CGFloat = 40.0) {
        super.init(frame: CGRect.zero)
        
        self.dimension = dimension
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Custom Methods
    func setup() {
        self.backgroundColor = UIColor.clear
        
        if shouldUpdateSpinnerColor && shouldShowTrailColors && trailColors.count > 0 {
            spinnerColor = trailColors[0]
        }
        
        let padding: CGFloat = dimension/13
        
        let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        let frameWithPadding = bounds.inset(by: insets)
        
        let startAngle: CGFloat = CGFloat(-90).toRadians()
        let endAngle: CGFloat = (clockwiseDirection) ? CGFloat(270).toRadians() : CGFloat(-450).toRadians()
        path = UIBezierPath(arcCenter: CGPoint(x: frameWithPadding.midX, y: frameWithPadding.midY),
                            radius: (frameWithPadding.size.width)/2,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: clockwiseDirection)
        
        circleLayer = CAShapeLayer()
        circleLayer.path = self.path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = circleColor.cgColor
        circleLayer.lineWidth = thickness
        
        self.layer.addSublayer(circleLayer)
        
        if shouldShowTrailColors {
            trailLayer1 = CAShapeLayer()
            trailLayer1.fillColor = UIColor.clear.cgColor
            trailLayer1.strokeColor = self.trailColors[self.currentColorIndex].cgColor
            trailLayer1.strokeEnd = 0.0
            trailLayer1.path = path.cgPath
            trailLayer1.lineWidth = thickness
            self.layer.addSublayer(trailLayer1)
            
            trailLayer2 = CAShapeLayer()
            trailLayer2.fillColor = UIColor.clear.cgColor
            trailLayer2.strokeColor = self.trailColors[self.currentColorIndex].cgColor
            trailLayer2.strokeEnd = 0.0
            trailLayer2.path = path.cgPath
            trailLayer2.lineWidth = thickness
            self.layer.addSublayer(trailLayer2)
        }
        if shouldShowSpinner {
            if thickness < 2.0 * padding {
                let spinnerShape = UIBezierPath(ovalIn: CGRect(x: -padding, y: -padding, width: 2.0 * padding, height: 2.0 * padding))
                
                spinnerLayer = CAShapeLayer()
                spinnerLayer.path = spinnerShape.cgPath
                spinnerLayer.fillColor = spinnerColor.cgColor
                spinnerLayer.strokeColor = UIColor.clear.cgColor
                spinnerLayer.zPosition = 2.0
                self.layer.addSublayer(spinnerLayer)
            }
            else {
                shouldShowSpinner = false
            }
        }
        self.setupAnimations()
    }
    
    private func setupAnimations() {
        if shouldShowSpinner {
            spinnerAnimation = CAKeyframeAnimation(keyPath: "position")
            spinnerAnimation.path = path.cgPath
            spinnerAnimation.calculationMode = CAAnimationCalculationMode.paced
            spinnerAnimation.repeatCount = .infinity
            spinnerAnimation.duration = duration
        }
        
        if shouldShowTrailColors {
            trail1Animation = CABasicAnimation(keyPath: "strokeEnd")
            trail1Animation.fromValue = 0.0
            trail1Animation.toValue = 1.0
            trail1Animation.repeatCount = 1
            trail1Animation.duration = duration
            trail1Animation.fillMode = CAMediaTimingFillMode.forwards
            trail1Animation.isRemovedOnCompletion = false
            trail1Animation.delegate = self
            trail2Animation = CABasicAnimation(keyPath: "strokeEnd")
            trail2Animation.fromValue = 0.0
            trail2Animation.toValue = 1.0
            trail2Animation.repeatCount = 1
            trail2Animation.duration = self.duration
            trail2Animation.fillMode = CAMediaTimingFillMode.forwards
            trail2Animation.isRemovedOnCompletion = false
            trail2Animation.delegate = self
        }
    }
    
    func startAnimating() {
        if shouldShowSpinner {
            spinnerLayer.add(spinnerAnimation, forKey: "spinnerAnimation")
        }
        if self.shouldShowTrailColors {
            if self.isAnimatingFirstTrailLayer {
                self.trailLayer1.add(self.trail1Animation, forKey: "trail1Animation")
            }
            else {
                self.trailLayer2.add(self.trail2Animation, forKey: "trail2Animation")
            }
        }
    }
    
    private func animateColorChange() {
        if self.shouldShowTrailColors {
            let animDuration = duration/4

            let colorChangeAnimation = CABasicAnimation(keyPath: "strokeColor")
            colorChangeAnimation.toValue = self.trailColors[self.currentColorIndex].cgColor
            colorChangeAnimation.duration = animDuration
            colorChangeAnimation.isRemovedOnCompletion = false
            colorChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
            
            if self.isAnimatingFirstTrailLayer {
                self.trailLayer1.add(colorChangeAnimation, forKey: "colorChangeAnimation")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + animDuration, execute: {
                    self.trailLayer1.removeAnimation(forKey: "colorChangeAnimation")
                    self.trailLayer1.strokeColor = self.trailColors[self.currentColorIndex].cgColor
                })
            }
            else {
                self.trailLayer2.add(colorChangeAnimation, forKey: "colorChangeAnimation")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + animDuration, execute: {
                    self.trailLayer2.removeAnimation(forKey: "colorChangeAnimation")
                    self.trailLayer2.strokeColor = self.trailColors[self.currentColorIndex].cgColor
                })
            }
            if shouldShowSpinner && shouldUpdateSpinnerColor {

                let spinnerColorChangeAnimation = CABasicAnimation(keyPath: "fillColor")
                spinnerColorChangeAnimation.toValue = self.trailColors[self.currentColorIndex].cgColor
                spinnerColorChangeAnimation.duration = animDuration
                spinnerColorChangeAnimation.isRemovedOnCompletion = false
                spinnerColorChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
                
                spinnerLayer.add(spinnerColorChangeAnimation, forKey: "spinnerColorChangeAnimation")

                DispatchQueue.main.asyncAfter(deadline: .now() + animDuration, execute: {
                    self.spinnerLayer.removeAnimation(forKey: "spinnerColorChangeAnimation")
                    self.spinnerLayer.fillColor = self.trailColors[self.currentColorIndex].cgColor
                })
            }
        }
    }
}

extension AnimationSpinner: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if self.isAnimatingFirstTrailLayer {
            trailLayer2.strokeColor = trailColors[currentColorIndex].cgColor
            trailLayer1.removeAllAnimations()
            trailLayer1.strokeEnd = 1.0
        } else {
            trailLayer1.strokeColor = trailColors[currentColorIndex].cgColor
            trailLayer2.removeAllAnimations()
            trailLayer2.strokeEnd = 1.0
        }
        if shouldShowSpinner {
            spinnerLayer.removeAnimation(forKey: "spinnerAnimation")
        }
        
        currentColorIndex = (currentColorIndex < trailColors.count - 1) ? currentColorIndex + 1 : 0
        isAnimatingFirstTrailLayer = !isAnimatingFirstTrailLayer
        
        if isAnimatingFirstTrailLayer {
            trailLayer1.zPosition = 1.0
            trailLayer2.zPosition = 0.0
        } else {
            trailLayer1.zPosition = 0.0
            trailLayer2.zPosition = 1.0
        }
        
        if self.shouldAnimateColorChange {
            animateColorChange()
        } else {
            if isAnimatingFirstTrailLayer {
                trailLayer1.strokeColor = trailColors[currentColorIndex].cgColor
            } else {
                trailLayer2.strokeColor = trailColors[currentColorIndex].cgColor
            }
            
            if shouldUpdateSpinnerColor {
                spinnerLayer.fillColor = trailColors[currentColorIndex].cgColor
            }
        }
        self.startAnimating()
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
