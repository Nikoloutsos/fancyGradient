//
//  FancyGradientView+Animation.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 6/11/21.
//

import Foundation
import UIKit


// MARK: Animation functions
extension FancyGradientView {
    public func animate(newDirection: Direction, duration: Double, animID: String? = nil) {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        let animationStartPoint = CABasicAnimation(keyPath: "startPoint")
        animationStartPoint.fromValue = currentState.direction.cgPoints.0
        animationStartPoint.toValue = newDirection.cgPoints.0

        let animationEndPoint = CABasicAnimation(keyPath: "endPoint")
        animationEndPoint.fromValue = currentState.direction.cgPoints.1
        animationEndPoint.toValue = newDirection.cgPoints.1

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animationStartPoint, animationEndPoint]
        animationGroup.duration = duration
        animationGroup.fillMode = .forwards;
        animationGroup.isRemovedOnCompletion = false
        animationGroup.repeatCount = 1
        if let id = animID { animationGroup.setValue(id, forKey: "CompletionId") }

        self.currentState = .init(direction: newDirection, colors: currentState.colors)

        animationGroup.delegate = self
        gradientLayer.add(animationGroup, forKey: nil)
    }

    public func animate(newColors: [UIColor], duration: Double, animID: String? = nil) {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.fromValue = currentState.colors.map{ $0.cgColor }
        colorAnimation.toValue = newColors.map{ $0.cgColor }
        colorAnimation.duration = duration
        colorAnimation.fillMode = .forwards;
        colorAnimation.isRemovedOnCompletion = false
        colorAnimation.repeatCount = 1
        if let id = animID { colorAnimation.setValue(id, forKey: "CompletionId") }

        self.currentState = .init(direction: currentState.direction, colors: newColors)

        colorAnimation.delegate = self
        gradientLayer.add(colorAnimation, forKey: nil)
    }

    /// Use this method to stop any animation
    public func stopAnimation() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.removeAllAnimations()
    }
}


// MARK: - CAAnimationDelegate
extension FancyGradientView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        // TODO: implement me
    }
}

public protocol FancyGradientViewDelegate: AnyObject {
    /// It will only be called if you have specified an animId
    func animationDidFinished(animId: String)
}


public struct CustomAnimation {
    



    func animate() {

    }
}
