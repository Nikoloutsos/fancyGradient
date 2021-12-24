//
//  EmptyAnimation.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 13/11/21.
//

import Foundation
import UIKit

/// Animation used for adding a delay. It's empty it doesn't animate anything.
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
