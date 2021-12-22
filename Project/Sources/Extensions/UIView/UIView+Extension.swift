//
//  UIView+extension.swift
//  BooksKeeper
//
//  Created by Viktoriya on 18.12.2021.
//

import UIKit

extension UIView {
    
//MARK: - Corner Radius param to Storyboard
        @IBInspectable
        var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
            }
        }
    
//MARK: - Animation for StartPageVC
    func rotate(duration: Double = 1) {
        
        DispatchQueue.main.async {
            if self.layer.animation(forKey: "rotationAnimationKey") == nil {
                let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
                self.layer.opacity = 1
                rotationAnimation.fromValue = 0.0
                rotationAnimation.toValue = Float.pi * 2.0
                rotationAnimation.duration = duration
                rotationAnimation.repeatCount = Float.infinity
                
                self.layer.add(rotationAnimation, forKey: "rotationAnimationKey")
            }
            
            self.setNeedsLayout()
        }
    }
    
    func stopRotating() {
        DispatchQueue.main.async {
            if self.layer.animation(forKey: "rotationAnimationKey") != nil {
                self.layer.opacity = .zero
                self.layer.removeAnimation(forKey: "rotationAnimationKey")
            }
            
            self.setNeedsLayout()
        }
    }

    func fadeIn(_ duration: TimeInterval = 0.5,
                delay: TimeInterval = 0.0,
                completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration,
                           delay: delay,
                           options: UIView.AnimationOptions.curveEaseInOut,
                           animations: {
                            self.alpha = 1.0
                           },
                           completion: completion)
        }
    }
}
