//
//  DirectionAnimation.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 13/11/21.
//

import Foundation
import UIKit

/// Animation for animating the direction of the gradient
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
