//
//  ActionButton.swift
//  EmailButton
//
//  Created by Denys Litvinskyi on 28.12.2021.
//

import UIKit

final class ActionButton: UIButton {
    
    // MARK: - Properties
    private let config: ActionButton.Configuration
    private let animator: Animator
    private var gradientLayer = CAGradientLayer()
    
    // MARK: - Init / Deinit methods
    init(config: ActionButton.Configuration) {
        self.config = config
        self.animator = config.animator
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        self.config = .email
        self.animator = ActionButton.Configuration.email.animator
        
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup(with: config)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let point = touches.first?.location(in: self) else {
            return
        }
        
        animator.animate(self, point: point)
    }
}

// MARK: - Private methods
extension ActionButton {
    
    private func setup(with config: ActionButton.Configuration) {
        backgroundColor = config.backgroundColor
        
        layer.masksToBounds = true
        layer.cornerRadius = config.cornderRadius
        
        gradientLayer.frame = bounds
        gradientLayer.startPoint = config.gradientStartPoint
        gradientLayer.endPoint = config.gradientEndPoint
        gradientLayer.masksToBounds = true
        
        gradientLayer.colors = config.gradientColors
        
        layer.insertSublayer(gradientLayer, at: 0)
        
        setTitle(config.title, for: .normal)
    }
}

// MARK: - Configuration
extension ActionButton {
    
    enum Configuration {
        case email
        
        var backgroundColor: UIColor {
            switch self {
            case .email:
                return UIColor(red: 29/255, green: 106/255, blue: 1, alpha: 1)
            }
        }
        
        var gradientColors: [CGColor] {
            switch self {
            case .email:
                return [
                    UIColor(red: 29/255, green: 180/255, blue: 1, alpha: 0.85),
                    UIColor(red: 29/255, green: 180/255, blue: 1, alpha: 0)
                ].map {$0.cgColor }
            }
        }
        
        var gradientStartPoint: CGPoint {
            switch self {
            case .email:
                return CGPoint(x: 1, y: 1)
            }
        }
        
        var gradientEndPoint: CGPoint {
            switch self {
            case .email:
                return CGPoint(x: 0.5, y: 0.5)
            }
        }
        
        var cornderRadius: CGFloat {
            switch self {
            case .email:
                return 16
            }
        }
        
        var title: String {
            switch self {
            case .email:
                return "Sign In"
            }
        }
        
        var animator: Animator {
            switch self {
            case .email:
                return RippleAnimator()
            }
        }
    }
}
