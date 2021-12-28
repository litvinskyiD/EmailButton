//
//  RippleAnimator.swift
//  EmailButton
//
//  Created by Denys Litvinskyi on 28.12.2021.
//

import Foundation
import UIKit

protocol Animator {
    func animate(_ view: UIView, point: CGPoint)
}

struct RippleAnimator: Animator {
    
    // MARK: - Properties
    let circleLayer = CAShapeLayer()
    
    // MARK: - Public methods
    func animate(_ view: UIView, point: CGPoint) {
        circleLayer.removeFromSuperlayer()
        circleLayer.removeAllAnimations()
        view.layer.removeAllAnimations()
        
        let circlePathFrom = UIBezierPath(roundedRect: CGRect(origin: point, size: .zero), cornerRadius: 0)
        let width = view.bounds.width * 2
        let circleRectTo = CGRect(
            x: point.x - width / 2,
            y: point.y - width / 2,
            width: width,
            height: width)
        let circlePathTo = UIBezierPath(roundedRect: circleRectTo, cornerRadius: width / 2)
        
        circleLayer.fillColor = UIColor.white.cgColor
        view.layer.addSublayer(circleLayer)
        
        CATransaction.begin()
        
        let viewScaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        viewScaleAnimation.fromValue = 1
        viewScaleAnimation.toValue = 0.97
        viewScaleAnimation.duration = 0.3
        viewScaleAnimation.autoreverses = true
        view.layer.add(viewScaleAnimation, forKey: "animation.ripple.view.scale")
        
        let circlePathAnimation = CABasicAnimation(keyPath: "path")
        circlePathAnimation.fromValue = circlePathFrom.cgPath
        circlePathAnimation.toValue = circlePathTo.cgPath
        circlePathAnimation.duration = 0.3
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = 0.3
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 0.3
        animationGroup.animations = [circlePathAnimation, opacityAnimation]
        circleLayer.add(animationGroup, forKey: "animation.ripple.circle.group")
        
        CATransaction.commit()
    }
}
