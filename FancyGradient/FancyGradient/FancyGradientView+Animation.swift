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
    public func foo() {
        let animation = CABasicAnimation(keyPath: "colors")
        animation.toValue = [UIColor.red, UIColor.green].map{ $0.cgColor }
        animation.duration = 3
        animation.fillMode = .forwards;
        animation.repeatCount = 1

        let animationGroup1 = CAAnimationGroup()
        animationGroup1.animations = [animation]
        animationGroup1.duration = 3
        animationGroup1.repeatCount = 1
        animationGroup1.fillMode = .forwards


        let animationGroup2 = CAAnimationGroup()
        animationGroup2.animations = [animation]
        animationGroup2.duration = 3
        animationGroup2.repeatCount = 1
        animationGroup2.fillMode = .forwards
        animationGroup2.isRemovedOnCompletion = false

        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.add(animationGroup2, forKey: nil)
    }


    public func animate(animation: CustomAnimation) {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.add(animation.caAnimation, forKey: nil)
    }

    public func animate(newDirection: Direction, duration: Double, animID: String? = nil) {}

    public func animate(newColors: [UIColor], duration: Double, animID: String? = nil) {}

    /// Use this method to stop any animation
    public func stopAnimation() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.removeAllAnimations()
    }
}

public protocol FancyGradientViewDelegate: AnyObject {
    /// It will only be called if you have specified an animId
    func animationDidFinished(animId: String)
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

public class CustomAnimation: Animationable {
    var animationsQueue: [[Animationable]] = []
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

    public func then(_ animation: Animationable) -> Self {
        animationsQueue.append([animation])
        return self
    }

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

// MARK: - CAAnimationDelegate
extension FancyGradientView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print(anim.value(forKey: "CompletionId"))
    }
}
