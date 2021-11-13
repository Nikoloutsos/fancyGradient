//
//  ColorStopsAnimation.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 13/11/21.
//

import Foundation
import UIKit

/// Animation for colorStops of gradient
public class ColorStopsAnimation: Animationable {
    let colorStops: [Double]?
    public let duration: Double

    lazy public var caAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.toValue = colorStops?.map{ NSNumber(value: $0) }
        animation.duration = duration
        animation.fillMode = .forwards;
        animation.repeatCount = 1
        return animation
    }()

    public init(colorStops: [Double]?, duration: Double) {
        self.colorStops = colorStops
        self.duration = duration
    }
}
