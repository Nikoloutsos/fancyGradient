//
//  Animationable.swift
//  FancyGradient
//
//  Created by Nikoloutsos, Konstantinos, Vodafone on 13/11/21.
//

import Foundation
import UIKit

/// Base protocol for all Animations
public protocol Animationable {
    var caAnimation: CAAnimation { get }
    var duration: Double { get }
}
