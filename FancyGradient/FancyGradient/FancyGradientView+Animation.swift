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
    public func animate(animation: CustomAnimation) {
        gradientLayer.add(animation.caAnimation, forKey: nil)
    }

    public func animate(newDirection: Direction, duration: Double, animID: String? = nil) {
        let customAnimation = CustomAnimation(animID: animID)
            .then(DirectionAnimation(newDirection: newDirection, duration: duration))
        animate(animation: customAnimation)
    }

    public func animate(newColors: [UIColor], duration: Double, animID: String? = nil) {
        let customAnimation = CustomAnimation(animID: animID)
            .then(ColorAnimation(newColors: newColors, duration: duration))
        animate(animation: customAnimation)
    }

    /// Use this method to stop any animation
    public func stopAnimation() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.removeAllAnimations()
    }
}

public protocol Animationable {
    var caAnimation: CAAnimation { get }
    var duration: Double { get }
}

public class DirectionAnimation: Animationable {
    let direction: Direction
    public let duration: Double

    lazy public var caAnimation: CAAnimation = {
        let animationStartPoint = CABasicAnimation(keyPath: "startPoint")
        animationStartPoint.toValue = direction.cgPoints.0
        animationStartPoint.duration = duration
        let animationEndPoint = CABasicAnimation(keyPath: "endPoint")
        animationEndPoint.toValue = direction.cgPoints.1
        animationEndPoint.duration = duration

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animationStartPoint, animationEndPoint]
        animationGroup.duration = duration
        animationGroup.repeatCount = 1
        animationGroup.fillMode = .forwards
        return animationGroup
    }()

    public init(newDirection: Direction, duration: Double) {
        self.direction = newDirection
        self.duration = duration
    }
}

public class ColorAnimation: Animationable {
    let colors: [UIColor]
    public let duration: Double

    lazy public var caAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "colors")
        animation.toValue = colors.map{ $0.cgColor }
        animation.duration = duration
        animation.fillMode = .forwards;
        animation.repeatCount = 1
        return animation
    }()

    public init(newColors: [UIColor], duration: Double) {
        self.colors = newColors
        self.duration = duration
    }
}

public class EmptyAnimation: Animationable {
    public let duration: Double

    lazy public var caAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "")
        animation.duration = duration
        animation.fillMode = .forwards;
        animation.repeatCount = 1
        return animation
    }()

    public init(duration: Double) {
        self.duration = duration
    }
}

/// CustomAnimation can be used for creating any animation.
/// The only barrier is your imagination 🌈
public class CustomAnimation: Animationable {
    private var animationsQueue: [[Animationable]] = []
    let animID: String?

    lazy public var caAnimation: CAAnimation = {
        var currentDuration: Double = 0
        let caAnimationsGroups: [CAAnimationGroup] = animationsQueue.map {
            let group = CAAnimationGroup()
            group.animations = $0.map { $0.caAnimation }
            group.duration = $0.reduce(0, {durationSum, animation in durationSum + animation.duration})
            group.repeatCount = 1
            group.fillMode = .forwards
            group.beginTime = currentDuration
            currentDuration += group.duration
            return group
        }

        let groupOfGroups = CAAnimationGroup()
        groupOfGroups.animations = caAnimationsGroups
        groupOfGroups.duration = caAnimationsGroups.reduce(0, {durationSum, animationGroup in durationSum + animationGroup.duration})
        groupOfGroups.fillMode = .forwards
        groupOfGroups.isRemovedOnCompletion = false
        groupOfGroups.repeatCount = 1
        if let animID = animID { groupOfGroups.setValue(animID, forKey: "CompletionId") }

        return groupOfGroups
    }()

    lazy public var duration: Double = {
        animationsQueue.reduce(0, { $0 + $1.reduce(0, {durationSum, animation in durationSum + animation.duration})})
    }()

    public init(animID: String? = nil) {
        self.animID = animID
    }

    /// Add the next animation that you want to apply
    public func then(_ animation: Animationable) -> Self {
        animationsQueue.append([animation])
        return self
    }

    /// Add the next animation that you want to apply
    public func then(_ operator: Operator) -> Self {
        switch `operator` {
        case .group(let animationGroup):
            animationsQueue.append(animationGroup)
            break
        }
        return self
    }

    public enum Operator {
        case group(animations: [Animationable])
    }
}

/// Get notified when animation terminated. Remember you have to set an animID to your CustomAnimation.
public protocol FancyGradientViewDelegate: AnyObject {
    func animationDidFinished(animId: String)
}

// MARK: - CAAnimationDelegate
extension FancyGradientView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animID = anim.value(forKey: "CompletionId") as? String {
            animationDelegate?.animationDidFinished(animId: animID)
        }
    }
}
