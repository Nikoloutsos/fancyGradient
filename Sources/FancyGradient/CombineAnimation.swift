//
//  CombineAnimation.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 13/11/21.
//

import Foundation
import UIKit

/// Animation used for simultaneously run 2 or more Animations. For example animate color and direction of gradient at the same time.
public class CombineAnimation: Animationable {
    let animations: [Animationable]

    lazy public var caAnimation: CAAnimation = {
        let group = CAAnimationGroup()
        group.animations = animations.map(\.caAnimation)
        group.duration = duration
        group.repeatCount = 1
        group.fillMode = .forwards
        return group
    }()

    lazy public var duration: Double = {
        animations.map(\.duration).max() ?? 0
    }()

    public init(_ animations: Animationable...) {
        self.animations = animations
    }
}
