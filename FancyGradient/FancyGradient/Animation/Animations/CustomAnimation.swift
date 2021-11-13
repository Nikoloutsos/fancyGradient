//
//  CustomAnimation.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 13/11/21.
//

import Foundation
import UIKit

/// CustomAnimation can be used for creating any animation.
/// The only barrier is your imagination 🌈
public class CustomAnimation: Animationable {
    private var animationsQueue: [[Animationable]] = []
    let animID: String?

    lazy public var caAnimation: CAAnimation = {
        var currentDuration: Double = 0
        let caAnimationsGroups: [CAAnimationGroup] = animationsQueue.map {
            let group = CAAnimationGroup()
            group.animations = $0.map(\.caAnimation)
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

    /// Adds the next animation that you want to apply in the chain
    public func then(_ animation: Animationable) -> Self {
        animationsQueue.append([animation])
        return self
    }
}
