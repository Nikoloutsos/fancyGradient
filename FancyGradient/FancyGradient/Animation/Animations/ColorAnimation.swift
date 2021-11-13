//
//  ColorAnimation.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 13/11/21.
//

import Foundation
import UIKit

/// Animation for animating the color of the gradient
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

    /// - Parameters:
    ///   - newColors: values should be hex strings (e.g #FF0000)
    ///   - duration: animation duration in seconds
    public init(newColors: [String], duration: Double) {
        self.colors = newColors.map{ .init(hexString: $0) }
        self.duration = duration
    }
}

