//
//  FancyGradientView+Animation.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 6/11/21.
//

import Foundation
import UIKit

/// Get notified when animation terminated. Remember you have to set an animID to your CustomAnimation.
public protocol FancyGradientViewDelegate: AnyObject {
    func animationDidFinished(animId: String)
}

// MARK: Animation functions
extension FancyGradientView {
    /// Animate with a custom animation
    /// - Parameter animation: The custom animation
    public func animate(animation: CustomAnimation) {
        animation.caAnimation.delegate = self
        gradientLayer.add(animation.caAnimation, forKey: nil)
    }

    /// Animate gradient direction
    /// - Parameters:
    ///   - newDirection: new gradient direction value.
    ///   - duration: the duration of animation in seconds. Min duration is 0.25
    ///   - animID: animID + delegate for get notified when animation ended.
    public func animate(newDirection: Direction, duration: Double, animID: String? = nil) {
        let customAnimation = CustomAnimation(animID: animID)
            .then(DirectionAnimation(newDirection: newDirection, duration: duration))
        animate(animation: customAnimation)
    }

    /// Animate gradient colors
    /// - Parameters:
    ///   - newColors: new gradient colors value
    ///   - duration: the duration of animation in seconds. Min duration is 0.25
    ///   - animID: animID + delegate for get notified when animation ended.
    public func animate(newColors: [UIColor], duration: Double, animID: String? = nil) {
        let customAnimation = CustomAnimation(animID: animID)
            .then(ColorAnimation(newColors: newColors, duration: duration))
        animate(animation: customAnimation)
    }

    /// Animate gradient colors
    /// - Parameters:
    ///   - newColorStops: new colorStops of gradient
    ///   - duration: the duration of animation in seconds. Min duration is 0.25
    ///   - animID: animID + delegate for get notified when animation ended.
    public func animate(newColorStops: [Double], duration: Double, animID: String? = nil) {
        let customAnimation = CustomAnimation(animID: animID)
            .then(ColorStopsAnimation(colorStops: newColorStops, duration: duration))
        animate(animation: customAnimation)
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
        if let animID = anim.value(forKey: "CompletionId") as? String, flag {
            delegate?.animationDidFinished(animId: animID)
        }
    }
}
